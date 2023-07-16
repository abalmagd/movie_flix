import 'package:flutter/material.dart';
import 'package:movie_flix/config/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/theme/palette.dart';

class MediaPosterShimmer extends StatelessWidget {
  const MediaPosterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      period: const Duration(seconds: 2),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) => AspectRatio(
          aspectRatio: 2 / 3,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Constants.mediaPosterCornerRadius),
              color: Palette.white.withOpacity(0.3),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: 4,
      ),
    );
  }
}
