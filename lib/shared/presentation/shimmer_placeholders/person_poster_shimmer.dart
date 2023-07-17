import 'package:flutter/material.dart';
import 'package:movie_flix/config/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/theme/palette.dart';

class PersonPosterShimmer extends StatelessWidget {
  const PersonPosterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      period: const Duration(seconds: 2),
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
          mainAxisExtent: 225,
        ),
        itemBuilder: (context, index) {
          return AspectRatio(
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
          );
        },
        itemCount: 6,
      ),
    );
  }
}
