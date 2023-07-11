import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';

import '../../../../config/theme/palette.dart';
import '../../domain/media.dart';
import '../riverpod/media_state.dart';

class MediaPoster extends ConsumerStatefulWidget {
  const MediaPoster({
    Key? key,
    required this.media,
    required this.state,
  }) : super(key: key);

  final Media media;
  final MediaState state;

  @override
  ConsumerState<MediaPoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends ConsumerState<MediaPoster> {
  int t = 0;
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
                '${RemoteEnvironment.tmdbImage}${RemoteEnvironment.posterQuality}${widget.media.posterPath}?t=$t',
                errorBuilder: (_, __, ___) {
                  Timer(const Duration(seconds: 5), () {
                    setState(() {
                      t++;
                    });
                  });
                  return const Text('Error loading this image!');
                },
                filterQuality: FilterQuality.none,
                width: double.infinity,
                height: double.infinity,
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
                                widget.media.title,
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
                                    children: widget.media.genreIds
                                        .map(
                                          (id) => Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Palette.white
                                              .withOpacity(0.24),
                                          border: Border.all(
                                            color: Palette.white,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: widget.state.genres.when(
                                              data: (genres) {
                                                return Text(
                                                  genres
                                                      .firstWhere(
                                                        (genre) =>
                                                            genre.id == id,
                                                      )
                                                      .name,
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                color: Palette.white,
                                              ),
                                            );
                                          },
                                          error: (_, __) {
                                            return const Text('failed');
                                          },
                                          loading: () {
                                            return const CircularProgressIndicator();
                                          },
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
                                    '${widget.media.releaseDate.year}',
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
                                    widget.media.voteAverage.toStringAsFixed(1),
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
