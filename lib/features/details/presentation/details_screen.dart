import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';
import 'package:movie_flix/shared/presentation/info_chip.dart';
import 'package:movie_flix/shared/presentation/network_fading_image.dart';
import 'package:movie_flix/utils/extensions.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../config/constants.dart';
import '../../../config/theme/palette.dart';
import '../../../shared/data/environment_variables.dart';
import '../../../shared/presentation/drawer/primary_drawer.dart';
import '../../../shared/presentation/theme_icon_button.dart';
import '../../../utils/assets.dart';
import '../../../utils/strings.dart';
import '../../home/domain/media.dart';
import '../../home/presentation/riverpod/movies/movies_controller.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key, required this.media});

  static const route = '/details';

  final Media media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final read = ref.read(moviesControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const PrimaryDrawer(),
      appBar: AppBar(
        backgroundColor: Palette.transparent,
        leading: FrostedContainer(
          outerPadding: const EdgeInsets.all(8),
          child: Builder(builder: (context) {
            return IconButton(
              icon: SvgPicture.asset(Assets.drawerIcon),
              color: Palette.white,
              onPressed: Scaffold.of(context).openDrawer,
            );
          }),
        ),
        actions: const [
          FrostedContainer(
            outerPadding: EdgeInsets.all(8),
            borderRadius: 20,
            child: ThemeIconButton(color: Palette.white),
          ),
        ],
      ),
      body: SnappingSheet(
        grabbingHeight: 300,
        grabbing: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            FrostedContainer(
              borderRadiusGeometry: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              backgroundColor: null,
              blurStrength: 10,
              child: Container(
                height: Constants.mediaDetailPosterHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: Constants.mediaDetailPosterHeight - 30,
                            width: Constants.mediaDetailPosterHeight *
                                    Constants.mediaPosterAspectRatio +
                                20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    media.title,
                                    style: theme.textTheme.titleLarge,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            spacing: 4,
                                            runSpacing: 8,
                                            children: [
                                              if (media.adult)
                                                const InfoChip(
                                                  text: 'Adult',
                                                  noOpacity: true,
                                                  backgroundColor:
                                                      Palette.danger,
                                                ),
                                              InfoChip(
                                                text:
                                                    '${media.voteCount.kFormat} Reviews',
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          read.genres.when(
                                            data: (genres) {
                                              return Wrap(
                                                direction: Axis.horizontal,
                                                spacing: 4,
                                                runSpacing: 8,
                                                children: media.genreIds
                                                    .map(
                                                      (id) => InfoChip(
                                                          text: genres
                                                              .firstWhere(
                                                                (genre) =>
                                                                    genre.id ==
                                                                    id,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      width: Constants.mediaDetailPosterHeight *
                              Constants.mediaPosterAspectRatio +
                          40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${media.releaseDate.year}',
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
                            media.voteAverage.toStringAsFixed(1),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Palette.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 30,
              child: SizedBox(
                height: Constants.mediaDetailPosterHeight,
                child: AspectRatio(
                  aspectRatio: Constants.mediaPosterAspectRatio,
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
        sheetBelow: SnappingSheetContent(
          child: FrostedContainer(
            borderRadius: 0,
            blurStrength: 10,
            backgroundColor: null,
            child: Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.5),
                border: Border(
                    top: BorderSide(
                  color: theme.primaryColor,
                  width: 2,
                )),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  const SizedBox(height: 8),
                  const SectionHeadline(text: Strings.overview),
                  Text(media.overview),
                ],
              ),
            ),
          ),
        ),
        snappingPositions: const [
          SnappingPosition.pixels(
              positionPixels: Constants.mediaDetailPosterHeight),
          SnappingPosition.factor(positionFactor: 0.83),
        ],
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                theme.scaffoldBackgroundColor,
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

class SectionHeadline extends StatelessWidget {
  const SectionHeadline({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(
          width: Text(text, style: theme.textTheme.titleSmall).textSize.width,
          child: Divider(
            color: theme.primaryColor,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
