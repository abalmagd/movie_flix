import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:movie_flix/shared/presentation/network_fading_image.dart';
import 'package:movie_flix/shared/presentation/primary_appbar.dart';
import 'package:movie_flix/utils/extensions.dart';

import '../../../shared/data/environment_variables.dart';
import '../../../shared/presentation/drawer/primary_drawer.dart';
import '../../home/domain/media.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.media});

  static const route = '/details';

  final Media media;
  final double posterHeight = 150;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          NetworkFadingImage(
            fit: BoxFit.cover,
            height: size.height * 0.6,
            width: double.infinity,
            path: '${RemoteEnvironment.tmdbImage}'
                '${RemoteEnvironment.ogBackdropQuality}'
                '${media.backdropPath}',
          ),
          ListView(
            children: [
              Container(
                height: 22,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: theme.scaffoldBackgroundColor,
                  color: theme.primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                height: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
