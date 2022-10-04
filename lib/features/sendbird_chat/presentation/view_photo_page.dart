import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';

class ViewPhotoPageArg {
  ViewPhotoPageArg({this.imageUrl, this.file});

  final String? imageUrl;
  final File? file;
}

class ViewPhotoPage extends StatelessWidget {
  const ViewPhotoPage({Key? key, required this.arg}) : super(key: key);

  static const String routeName = '/viewPhotoPage';

  final ViewPhotoPageArg arg;

  @override
  Widget build(BuildContext context) {
    late ImageProvider imageProvider;

    if (arg.file != null) {
      imageProvider = FileImage(arg.file!);
    } else if (arg.imageUrl != null) {
      imageProvider = CachedNetworkImageProvider(arg.imageUrl!);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image(image: imageProvider),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      SvgAssets.icClose,
                      color: Colors.white,
                      height: 21.h,
                      width: 21.w,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
