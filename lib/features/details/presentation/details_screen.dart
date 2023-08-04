import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';
import 'package:movie_flix/shared/presentation/network_fading_image.dart';
import 'package:movie_flix/shared/presentation/primary_appbar.dart';
import 'package:movie_flix/utils/extensions.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../config/theme/palette.dart';
import '../../../shared/data/environment_variables.dart';
import '../../../shared/presentation/drawer/primary_drawer.dart';
import '../../home/domain/media.dart';
import '../../home/presentation/riverpod/movies/movies_controller.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key, required this.media});

  static const route = '/details';

  final Media media;
  final double posterHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final read = ref.read(moviesControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const PrimaryDrawer(),
      appBar: PrimaryAppBar(
        titleWidget: LayoutBuilder(
          builder: (context, size) {
            final willOverflow =
                Text(media.title, style: theme.textTheme.titleLarge)
                    .willTextOverflow(maxWidth: size.maxWidth);

            return willOverflow
                ? SizedBox(
              height: kToolbarHeight,
              child: Marquee(
                text: media.title,
                pauseAfterRound: const Duration(seconds: 5),
                      blankSpace: 12,
                      velocity: 25,
                      accelerationCurve: Curves.linear,
                      decelerationCurve: Curves.easeOut,
                    ),
                  )
                : Text(media.title);
          },
        ),
      ),
      body: SnappingSheet(
        grabbingHeight: 75,
        // TODO: Add your grabbing widget here,
        grabbing: const Center(child: Text('drag')),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          // TODO: Add your sheet content here
          child: Stack(
            children: [
              FrostedContainer(
                tightPadding: true,
                blurStrength: 8,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Container(
                            width: 200 * (2 / 3),
                            color: Colors.red,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 4,
                            runSpacing: 8,
                            children: media.genreIds
                                .map(
                                  (id) => Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Palette.white.withOpacity(0.24),
                                      border: Border.all(
                                        color: Palette.white,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: read.genres.when(
                                      data: (genres) {
                                        return Text(
                                          genres
                                              .firstWhere(
                                                (genre) => genre.id == id,
                                              )
                                              .name,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Palette.white,
                                          ),
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
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: size.height - 200 - 125,
                left: 20,
                child: SizedBox(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: NetworkFadingImage(
                        fit: BoxFit.cover,
                        path: '${RemoteEnvironment.tmdbImage}'
                            '${RemoteEnvironment.ogBackdropQuality}'
                            '${media.posterPath}',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // TODO: Add your content that is placed
        // behind the sheet. (Can be left empty)
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Palette.transparent,
              ],
            ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
          },
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
            ),
            items: [
              NetworkFadingImage(
                fit: BoxFit.cover,
                path: '${RemoteEnvironment.tmdbImage}'
                    '${RemoteEnvironment.ogBackdropQuality}'
                    '${media.backdropPath}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: FrostedContainer(
                    tightPadding: true,
                    blurStrength: 8,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                width: 200 * (2 / 3),
                                color: Colors.red,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 4,
                                runSpacing: 8,
                                children: media.genreIds
                                    .map(
                                      (id) => Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Palette.white.withOpacity(0.24),
                                      border: Border.all(
                                        color: Palette.white,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: read.genres.when(
                                      data: (genres) {
                                        return Text(
                                          genres
                                              .firstWhere(
                                                (genre) => genre.id == id,
                                          )
                                              .name,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Palette.white,
                                          ),
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
                                )
                                    .toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height - 200 - 125,
                  left: 20,
                  child: SizedBox(
                    height: 200,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: NetworkFadingImage(
                          fit: BoxFit.cover,
                          path: '${RemoteEnvironment.tmdbImage}'
                              '${RemoteEnvironment.ogBackdropQuality}'
                              '${media.posterPath}',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
*/
