import 'package:flutter/material.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';
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
                '${RemoteEnvironment.tmdbImage}${widget.movie.posterPath}',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              AnimatedOpacity(
                opacity: showInfo ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: FrostedContainer(
                  tightPadding: true,
                  borderRadius: 0,
                  blurStrength: 8,
                  child: Column(
                    children: [
                      Text(widget.movie.title, maxLines: 2),
                      Wrap(),
                      const Spacer(),
                      Row(
                        children: [
                          Text('${widget.movie.releaseDate.year}'),
                          const Spacer(),
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Palette.starOrange,
                            size: 20,
                          ),
                          Text('${widget.movie.voteAverage}'),
                        ],
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
