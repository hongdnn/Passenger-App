import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';

class CarDetailArgs {
  CarDetailArgs({
    this.currentCarTypeId,
  });
  final int? currentCarTypeId;
}

class CarDetailWidget extends StatefulWidget {
  const CarDetailWidget({
    Key? key,
    this.args,
  }) : super(key: key);
  static const String routeName = '/carDetailWidget';
  final CarDetailArgs? args;

  @override
  State<CarDetailWidget> createState() => _CarDetailWidgetState();
}

class _CarDetailWidgetState extends State<CarDetailWidget> {
  late final PageController _carController;
  late final PageController _carDetailController;

  late ValueNotifier<int> currentPage;

  /// Use to prevent recursive trigger PaegController listeners
  int _carDetailControllerPage = 0;
  int _carControllerPage = 0;

  @override
  void initState() {
    currentPage = ValueNotifier<int>(widget.args?.currentCarTypeId ?? 0);
    _carDetailController = PageController(
      initialPage: widget.args?.currentCarTypeId ?? 0,
    );
    _carController = PageController(
      viewportFraction: 0.64.h,
      initialPage: widget.args?.currentCarTypeId ?? 0,
    );
    _initPageControllerListener();
    super.initState();
  }

  @override
  void dispose() {
    _carController.dispose();
    _carDetailController.dispose();
    super.dispose();
  }

  _initPageControllerListener() {
    _carController.addListener(() {
      if (_carDetailControllerPage == currentPage.value) return;
      _animateCar();
    });

    _carDetailController.addListener(() {
      if (_carControllerPage == currentPage.value) return;
      _animateCarDetail();
    });
  }

  _animateCar() async {
    _carDetailControllerPage = currentPage.value;
    await _carDetailController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  _animateCarDetail() async {
    _carControllerPage = currentPage.value;
    await _carController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstant.c80Black.withOpacity(0.85),
      body: Stack(
        children: <Widget>[
          _cars(),
          _closeButton(context),
          _bottomSheet(context),
        ],
      ),
    );
  }

  Align _bottomSheet(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 514.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorsConstant.cWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              BlocBuilder<BookingPageBloc, BookingPageState>(
                builder: (BuildContext context, BookingPageState state) {
                  if (state.carDescLoadState == LoadState.success) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: _carDetails(
                        context: context,
                        carInformation:
                            state.carDescription?.data ?? <CarInformation>[],
                      ),
                    );
                  }
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 468.h,
                      child: const Center(child: CupertinoActivityIndicator()),
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _indicatorDots(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _carDetails({
    required BuildContext context,
    required List<CarInformation> carInformation,
  }) {
    return SizedBox(
      height: 468.h,
      child: PageView.builder(
        itemCount: carInformation.length,
        itemBuilder: (_, int index) {
          final List<ListPrice> listOfCarsInformation =
              carInformation[index].listPrice ?? <ListPrice>[];
          if (listOfCarsInformation.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listOfCarsInformation.length,
                  itemBuilder: (_, int index) {
                    return _itemCarInformation(
                      listLength: listOfCarsInformation.length,
                      index: index,
                      label: _showKmLabel(
                        listOfCarsInformation[index],
                      ),
                      price: _buildPrice(
                        listOfCarsInformation[index],
                      ),
                      currency: _buildCurrency(
                        listOfCarsInformation[index],
                      ),
                    );
                  },
                  separatorBuilder: (_, int index) {
                    return Divider(
                      height: 1.h,
                      color: Colors.black12,
                    );
                  },
                ),
              ),
            );
          }
        },
        onPageChanged: (int page) {
          currentPage.value = page;
        },
        controller: _carDetailController,
      ),
    );
  }

  SizedBox _cars() {
    return SizedBox(
      height: 298.h,
      child: BlocBuilder<BookingPageBloc, BookingPageState>(
        builder: (BuildContext context, BookingPageState state) {
          if (state.carDescLoadState == LoadState.success) {
            return PageView.builder(
              itemCount: state.carDescription?.data?.length,
              itemBuilder: (_, int index) {
                final List<CarInformation>? listOfCarsName =
                    state.carDescription?.data;
                return _carItem(
                  typeSlogan: listOfCarsName?[index].typeSlogan ?? '',
                  typeName: listOfCarsName?[index].category ?? '',
                  carImage: listOfCarsName?[index].carImage ?? '',
                );
              },
              onPageChanged: (int page) {
                currentPage.value = page;
              },
              controller: _carController,
            );
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }

  Positioned _closeButton(BuildContext context) {
    return Positioned(
      right: 10.w,
      top: 46.h,
      child: IconButton(
        color: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          SvgAssets.icClose,
          color: ColorsConstant.cFFABADBA,
          height: 12.h,
          width: 12.h,
        ),
      ),
    );
  }

  Widget _indicatorDots() {
    return BlocBuilder<BookingPageBloc, BookingPageState>(
      builder: (_, BookingPageState state) => ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (_, int newIndex, Widget? error) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<AnimatedContainer>.generate(
              (state.carDescription?.data ?? <Widget>[]).length,
              (int index) {
                return AnimatedContainer(
                  height: 8.h,
                  width: 8.w,
                  margin: EdgeInsets.only(
                    right: index != 6 ? 8.w : 0.w,
                  ),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: currentPage.value != index
                        ? ColorsConstant.cFFF6E5F6
                        : ColorsConstant.cFFC04EC0,
                    borderRadius: BorderRadius.circular(
                      8.w,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column _carItem({
    required String typeName,
    required String typeSlogan,
    required String? carImage,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (carImage?.isNotEmpty == true)
            ? CachedNetworkImage(
                width: 169.w,
                height: 112.h,
                imageUrl: carImage!,
                errorWidget: (BuildContext context, String url, _) =>
                    SvgPicture.asset(
                  SvgAssets.icRbhCar,
                ),
                placeholder: (BuildContext context, String url) =>
                    const CupertinoActivityIndicator(),
              )
            : SvgPicture.asset(
                SvgAssets.icRbhCar,
              ),
        SizedBox(
          width: 169.w,
          child: Text(
            typeName,
            style: StylesConstant.ts20w500.copyWith(
              color: ColorsConstant.cWhite,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          style: StylesConstant.ts12w400.copyWith(
            color: ColorsConstant.cWhite,
          ),
          typeSlogan,
        )
      ],
    );
  }

  Padding _itemCarInformation({
    required int index,
    required String label,
    required String price,
    required int listLength,
    required String currency,
  }) {
    return Padding(
      padding: index == 0
          ? EdgeInsets.only(bottom: 16.h)
          : index == listLength
              ? EdgeInsets.only(top: 16.h)
              : EdgeInsets.symmetric(
                  vertical: 16.h,
                ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: StylesConstant.ts16w400.copyWith(
              color: ColorsConstant.cFF454754,
            ),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: price,
                  style: StylesConstant.ts16w400.copyWith(
                    color: ColorsConstant.cFFA33AA3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: currency,
                  style: StylesConstant.ts16w400.copyWith(
                    color: ColorsConstant.cFFA33AA3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _showKmLabel(ListPrice carsPriceInformation) {
    if (carsPriceInformation.minDistance == 0) {
      return '''${S(context).minimum} (<${carsPriceInformation.maxDistance} ${S(context).km})''';
    } else {
      return '''${S(context).per_km} (${carsPriceInformation.minDistance}-${carsPriceInformation.maxDistance} ${S(context).km})''';
    }
  }

  String _buildPrice(ListPrice carsPriceInformation) {
    final double price = double.parse('${carsPriceInformation.price}');
    final String defaultLocale = Localizations.localeOf(context).toString();
    if (defaultLocale == 'th') {
      if (carsPriceInformation.minDistance == 0) {
        return '${formatPrice(price)} ';
      } else {
        return '${formatPrice(price)} ${S(context).baht}/';
      }
    } else {
      if (carsPriceInformation.minDistance == 0) {
        return 'THB ${formatPrice(price)}';
      } else {
        return 'THB  ${formatPrice(price)}/';
      }
    }
  }

  String _buildCurrency(ListPrice carsPriceInformation) {
    final String defaultLocale = Localizations.localeOf(context).toString();
    if (defaultLocale == 'th') {
      if (carsPriceInformation.minDistance == 0) {
        return S(context).baht;
      } else {
        return S(context).km;
      }
    } else {
      if (carsPriceInformation.minDistance == 0) {
        return '';
      } else {
        return S(context).km;
      }
    }
  }
}
