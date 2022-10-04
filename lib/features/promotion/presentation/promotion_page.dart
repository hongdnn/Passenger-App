import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/checkout/presentation/checkout_page.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/features/promotion/data/model/promotion_infor.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_bloc.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_event.dart';
import 'package:passenger/features/promotion/presentation/bloc/promotion_page_state.dart';
import 'package:passenger/features/promotion/presentation/widgets/promotion_item.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_dialog.dart';
import 'package:passenger/util/widgets/search_appbar_widget.dart';

class PromotionPageArg {
  PromotionPageArg({this.tripPrice});

  double? tripPrice;
}

class PromotionPage extends StatefulWidget {
  const PromotionPage({Key? key, required this.args}) : super(key: key);

  static const String routeName = 'checkout/promotion';
  final PromotionPageArg args;

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  PromotionPageBloc? _bloc;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _bloc ??= getIt<PromotionPageBloc>();
    _bloc?.add(PromotionListInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          highlightColor: ColorsConstant.cTransparent,
          splashColor: ColorsConstant.cTransparent,
          onTap: () {
            Navigator.of(context).popUntil((Route<dynamic> route) {
              if (route.settings.name == CheckoutPage.routeName) {
                (route.settings.arguments as CheckoutArg).promotionInfor = null;
                return true;
              } else {
                return false;
              }
            });
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 30.w),
            child: SvgPicture.asset(
              SvgAssets.icBackIos,
              height: 18.h,
              width: 10.h,
            ),
          ),
        ),
        title: Text(
          S(context).promotion_page_title,
          style: StylesConstant.ts20w500,
        ),
      ),
      body: BlocProvider<PromotionPageBloc>(
        create: (BuildContext context) => _bloc!,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: <Widget>[
              _searchBox(),
              SizedBox(height: 24.h),
              _primaryContent(),
            ],
          ),
        ),
      ),
    );
  }

  SearchAppbarWidget _searchBox() {
    return SearchAppbarWidget(
      hintText: S(context).enter_promo_code_here,
      onChanged: (String text) {
        _bloc?.add(PromotionPageSearchEvent(keyword: text));
      },
    );
  }

  Expanded _primaryContent() {
    return Expanded(
      child: BlocConsumer<PromotionPageBloc, PromotionPageState>(
        listener: (BuildContext context, PromotionPageState state) {
          if (state.applyPromoLoadState == LoadState.failure) {
            _showApplyPromoErrorDialog();
          } else if (state.applyPromoLoadState == LoadState.success) {
            Navigator.of(context).popUntil((Route<dynamic> route) {
              if (route.settings.name == CheckoutPage.routeName) {
                (route.settings.arguments as CheckoutArg).promotionInfor =
                    PromotionInfor(
                  promotionData: state.promotionsApply,
                  discountAmount: state.discountAmount,
                );
                return true;
              } else {
                return false;
              }
            });
          }
        },
        builder: (BuildContext context, PromotionPageState state) {
          if (state.getPromotionsLoadState == LoadState.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (state.searchPromoLoadState == LoadState.failure) {
            return _emptyPromotion();
          }

          if (state.promotions?.isNotEmpty == true) {
            return _promotionList(
              state.promotions!,
              state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _promotionList(
    List<PromotionData> promotions,
    PromotionPageState promotionPageState,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: !promotionPageState.isLastPage
          ? _loadMore
          : (ScrollNotification notification) {
              return false;
            },
      child: RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: ListView.separated(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 8.h);
          },
          itemCount: promotions.length,
          itemBuilder: (BuildContext context, int i) {
            return PromotionItem(
              promotion: promotions[i],
              onSelect: (PromotionData promotion) {
                _bloc?.add(
                  PromotionPageApplyPromoEvent(
                    promotion: promotion,
                    tripPrice: widget.args.tripPrice,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Column _emptyPromotion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 250.h,
          width: 250.w,
          child: Center(
            child: SvgPicture.asset(SvgAssets.icSearchEmpty),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          S(context).search_empty_title,
          style: StylesConstant.ts16w500.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          S(context).search_empty_subtitle,
          overflow: TextOverflow.ellipsis,
          style: StylesConstant.ts12w400cFF73768C,
        ),
      ],
    );
  }

  _showApplyPromoErrorDialog() {
    showCustomDialog(
      context: context,
      options: CustomDialogParams.simpleAlert(
        title: S(context).apply_promotion_dialog_title,
        message: S(context).apply_promotion_dialog_msg,
        negativeTitle: S(context).agree,
      ),
    );
  }

  bool _loadMore(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter > listExtentAfter) {
        _onLoading();
      }
    }
    return false;
  }

  void _onLoading() {
    _bloc?.add(
      GetNextPagePromotionEvent(),
    );
    _bloc?.add(
      PromotionListUpdateOnLoadingEvent(
        isLazyLoading: true,
      ),
    );
  }

  Future<void> _onPullToRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    _bloc?.add(
      PromotionListUpdateOnLoadingEvent(),
    );
  }
}
