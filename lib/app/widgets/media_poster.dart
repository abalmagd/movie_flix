import 'package:flutter/material.dart';
import 'package:movie_flix/app/environment/spacing.dart';

import '../theme/palette.dart';

class MediaPoster extends StatelessWidget {
  const MediaPoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              'https://cdn.shopify.com/s/files/1/1057/4964/products/Avengers-Endgame-Vintage-Movie-Poster-Original-1-Sheet-27x41.jpg?v=1670821335',
              fit: BoxFit.cover,
            ),
          ),
          Text('title'),
          Row(
            children: const [
              Text('2013'),
              Spacer(),
              Text('9'),
              Icon(
                Icons.star_rounded,
                color: Palette.starOrange,
                size: Spacing.s14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
