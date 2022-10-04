import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:passenger/features/landing_page/data/model/banner_model.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';

class BannerSliderWidget extends StatefulWidget {
  const BannerSliderWidget({Key? key, required this.listImgBanner})
      : super(key: key);
  final List<BannerDetail> listImgBanner;
  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  final PageController _controller = PageController(
    viewportFraction: 0.8.w,
    initialPage: 0,
  );

  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  double currentOffset = 0;
  double dragOffset = 0;

  double kPadding = 24.w;
  double kSpaceBetween = 12.w;
  double kWidth = 300.w;

  late double xToSwap;
  late double yToSwap;

  int bannerCount = 0;

  @override
  void initState() {
    super.initState();
    yToSwap = kWidth + kSpaceBetween;
    xToSwap =
        kPadding + kSpaceBetween + kWidth + kWidth / 2 - ScreenSize.width / 2;
    bannerCount = widget.listImgBanner.length;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (bannerCount == 0) return const SizedBox.shrink();

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _bannerWidget(),
          SizedBox(
            height: 8.h,
          ),
          _indicatorWidget(),
        ],
      ),
    );
  }

  Widget _bannerWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (_, int newIndex, Widget? error) {
        return GestureDetector(
          onHorizontalDragStart: (DragStartDetails details) {},
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! < 0) {
              if (currentPage.value == 0) {
                currentOffset = currentOffset + xToSwap;
              } else if (currentPage.value == bannerCount - 1) {
              } else if (currentPage.value == bannerCount - 2) {
                currentOffset = currentOffset + xToSwap;
              } else {
                currentOffset = currentOffset + yToSwap;
              }
            } else {
              if (currentPage.value == 1) {
                currentOffset = 0;
              } else if (currentPage.value == 0) {
              } else if (currentPage.value == bannerCount - 1) {
                currentOffset = currentOffset - xToSwap;
              } else {
                currentOffset = currentOffset - yToSwap;
              }
            }

            _controller.animateTo(
              currentOffset,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );

            if (details.primaryVelocity! < 0) {
              if (currentPage.value < bannerCount - 1) {
                currentPage.value++;
              }
            } else {
              if (currentPage.value > 0) {
                currentPage.value--;
              }
            }
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {},
          child: SizedBox(
            height: 80.h,
            child: ListView.builder(
              padding: EdgeInsets.only(left: kPadding, right: kPadding),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, int index) {
                final String? imgBanner = widget.listImgBanner[index].url;
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: kSpaceBetween,
                    ),
                    height: 80.h,
                    width: kWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.w,
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: (imgBanner != '' && imgBanner != null)
                          ? CachedNetworkImage(
                              imageUrl: imgBanner,
                              errorWidget:
                                  (BuildContext context, String url, _) =>
                                      Image.asset(
                                PngAssets.icBanner,
                                fit: BoxFit.cover,
                              ),
                              placeholder: (BuildContext context, String url) =>
                                  const CupertinoActivityIndicator(),
                            )
                          : Image.asset(
                              PngAssets.icBanner,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
              controller: _controller,
              itemCount: bannerCount,
            ),
          ),
        );
      },
    );
  }

  Widget _indicatorWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (_, int newIndex, Widget? error) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<AnimatedContainer>.generate(
            bannerCount,
            (int index) {
              return AnimatedContainer(
                height: 4.h,
                width: currentPage.value == index ? 24.w : 8.w,
                margin: EdgeInsets.only(
                  right: 4.w,
                ),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: currentPage.value == index
                      ? ColorsConstant.appPrimaryGradient
                      : null,
                  color: ColorsConstant.cFFE3E4E8,
                  borderRadius: BorderRadius.circular(
                    9.w,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
