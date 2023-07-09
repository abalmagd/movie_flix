import 'package:flutter/material.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../config/theme/palette.dart';
import '../domain/movie.dart';

class MoviePoster extends StatefulWidget {
  const MoviePoster({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  bool showInfo = false;
  int t = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () => setState(() {
            showInfo = !showInfo;
          }),
          child: Stack(
            children: [
              Image.network(
                '${RemoteEnvironment.tmdbImage}${widget.movie.posterPath}?t=$t',
                errorBuilder: (_, __, ___) {
                  setState(() {
                    t++;
                  });
                  return const Text('error');
                },
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              AnimatedOpacity(
                opacity: showInfo ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: FrostedContainer(
                  tightPadding: true,
                  borderRadius: 0,
                  blurStrength: 12,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Palette.white),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 4,
                                    runSpacing: 8,
                                    children: widget.movie.genreIds
                                        .map(
                                          (e) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Utils.randomColor(),
                                              border: Border.all(
                                                color: Palette.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'genre',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Palette.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${widget.movie.releaseDate.year}',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Palette.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Palette.starOrange,
                                    size: 20,
                                  ),
                                  Text(
                                    '${widget.movie.voteAverage}',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Palette.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(32),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('Explore'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
