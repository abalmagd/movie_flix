import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/details/presentation/details_screen.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';
import 'package:movie_flix/shared/presentation/info_chip.dart';
import 'package:movie_flix/shared/presentation/network_fading_image.dart';

import '../../../../config/theme/palette.dart';
import '../../../../utils/strings.dart';
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
  ConsumerState<MediaPoster> createState() => _MediaPosterState();
}

class _MediaPosterState extends ConsumerState<MediaPoster> {
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
              NetworkFadingImage(
                path: '${RemoteEnvironment.tmdbImage}'
                    '${RemoteEnvironment.posterQuality}'
                    '${widget.media.posterPath}',
              ),
              AnimatedOpacity(
                opacity: showInfo ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: FrostedContainer(
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
                                  child: widget.state.genres.when(
                                    data: (genres) {
                                      return Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 4,
                                        runSpacing: 8,
                                        children: widget.media.genreIds
                                            .map(
                                              (id) => InfoChip(
                                                  text: genres
                                                      .firstWhere(
                                                        (genre) =>
                                                            genre.id == id,
                                                      )
                                                      .name),
                                            )
                                            .toList(),
                                      );
                                    },
                                    error: (_, __) {
                                      return const SizedBox.shrink();
                                    },
                                    loading: () {
                                      return const CircularProgressIndicator();
                                    },
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
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.route,
                            arguments: widget.media,
                          );
                        },
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
                        child: const Text(Strings.explore),
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
