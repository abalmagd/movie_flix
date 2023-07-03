import 'package:flutter/material.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';

import '../../config/theme/palette.dart';
import '../domain/movie.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                '${RemoteEnvironment.tmdbImage}${movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              color: Colors.blueGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      Text('${movie.releaseDate.year}'),
                      const Spacer(),
                      const Icon(
                        Icons.star_rounded,
                        color: Palette.starOrange,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(movie.voteAverage.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
