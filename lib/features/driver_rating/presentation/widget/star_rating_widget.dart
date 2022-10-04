import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passenger/util/assets.dart';
import 'package:passenger/util/size.dart';

const int defaultMaxStar = 5;

class StarRating extends StatefulWidget {
  const StarRating({
    Key? key,
    this.maxStar = defaultMaxStar,
    required this.onStarsSelected,
  }) : super(key: key);

  final int maxStar;
  final Function(int stars) onStarsSelected;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _selectedStars = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(widget.maxStar, (int index) {
          // Use +1 here to make star logic handling more natural,
          // otherwise index == 0 would mean stars = 1
          return _star(index + 1);
        }),
      ),
    );
  }

  Widget _star(int starCount) {
    final bool isSelected = starCount <= _selectedStars;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          if (starCount != _selectedStars) {
            setState(() {
              _selectedStars = starCount;
              widget.onStarsSelected(_selectedStars);
            });
          }
        },
        child: SvgPicture.asset(
          isSelected ? SvgAssets.icStarSelected : SvgAssets.icStarUnselected,
          height: 34.w,
          width: 34.w,
        ),
      ),
    );
  }
}
