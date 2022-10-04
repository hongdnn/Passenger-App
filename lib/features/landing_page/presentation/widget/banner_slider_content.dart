import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/features/landing_page/presentation/bloc/landing_page_bloc.dart';
import 'package:passenger/features/landing_page/presentation/widget/banner_slider_widget.dart';
import 'package:passenger/util/enum.dart';

class BannerSliderContent extends StatelessWidget {
  const BannerSliderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      buildWhen: (LandingPageState previous, LandingPageState current) {
        return previous.bannerLoadState != current.bannerLoadState ||
            previous.bannerResponse != current.bannerResponse;
      },
      builder: (BuildContext context, LandingPageState state) {
        if (state.bannerLoadState == LoadState.loading) {
          return const CupertinoActivityIndicator();
        }

        if (state.bannerResponse?.data?.isNotEmpty == true) {
          return BannerSliderWidget(
            listImgBanner: state.bannerResponse!.data!,
            key: const ValueKey<String>(
              'landing-page-banner-slider',
            ),
          );
        }

        // Add error UI if needed
        return const SizedBox.shrink();
      },
    );
  }
}
