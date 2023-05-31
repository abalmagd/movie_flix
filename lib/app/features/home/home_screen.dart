import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/environment/strings.dart';
import 'package:movie_flix/app/riverpod/home/home_controller.dart';
import 'package:movie_flix/app/riverpod/home/home_state.dart';
import 'package:movie_flix/app/widgets/drawer/primary_drawer.dart';
import 'package:movie_flix/app/widgets/media_poster.dart';
import 'package:movie_flix/app/widgets/primary_sliver_appbar.dart';
import 'package:movie_flix/remote/environment_variables.dart';
import '../../environment/spacing.dart';
import '../../theme/palette.dart';
import '../../widgets/frosted_container.dart';
import 'widgets/sliver_delegates.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> tabs = [
    const MoviesTab(),
    const SeriesTab(),
    const ActorsTab(),
  ];

  @override
  void initState() {
    super.initState();
    Future(() {
      ref
          .read(homeControllerProvider.notifier)
          .getMovieListByType(type: MovieListType.nowPlaying);
    });
  }

  final CarouselController _textCarouselController = CarouselController();
  final CarouselController _backdropCarouselController = CarouselController();
  final CarouselController _frontBackdropCarouselController =
      CarouselController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final watch = ref.watch(homeControllerProvider);
    return Scaffold(
      drawer: const PrimaryDrawer(),
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              watch.nowPlayingMovies.when(
                data: (movies) {
                  return PrimarySliverAppBar(
                    collapsedTitle: Text(
                      Strings.home,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(color: Palette.white),
                    ),
                    expandedTitle: CarouselSlider(
                      carouselController: _textCarouselController,
                      options: CarouselOptions(
                          autoPlay: false,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            if (reason.index == 1) {
                              _frontBackdropCarouselController
                                  .animateToPage(index);
                              _backdropCarouselController.animateToPage(index);
                            }
                          }),
                      items: movies.map(
                        (movie) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FrostedContainer(
                                  blurStrength: Spacing.s12,
                                  borderRadius: Spacing.s8,
                                  child: Text(
                                    Strings.inTheaters,
                                    style: theme.textTheme.labelLarge
                                        ?.copyWith(color: Palette.white),
                                  ),
                                ),
                                FrostedContainer(
                                  blurStrength: Spacing.s12,
                                  borderRadius: Spacing.s8,
                                  child: Text(
                                    movie.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: theme.textTheme.labelLarge
                                        ?.copyWith(color: Palette.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    expandedImage: CarouselSlider(
                      carouselController: _frontBackdropCarouselController,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: double.infinity,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 10),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1500),
                        onPageChanged: (index, reason) {
                          _textCarouselController.jumpToPage(index);
                          _backdropCarouselController.jumpToPage(index);
                        },
                      ),
                      items: movies.map(
                        (movie) {
                          return Image.network(
                            '${RemoteEnvironment.tmdbImage}${movie.backdropPath}',
                            errorBuilder: (_, __, ___) =>
                                const SizedBox.shrink(),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ).toList(),
                    ),
                    collapsedImage: CarouselSlider(
                      carouselController: _backdropCarouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        viewportFraction: 1,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        height: double.infinity,
                      ),
                      items: movies.map(
                        (movie) {
                          return Image.network(
                            '${RemoteEnvironment.tmdbImage}${movie.backdropPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
                error: (_, __) {
                  return PrimarySliverAppBar(
                    inverseColors: true,
                    collapsedTitle: Text(
                      Strings.home,
                      style: theme.textTheme.titleLarge,
                    ),
                    expandedTitle: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Spacing.s8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            Strings.error,
                            style: theme.textTheme.labelLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(homeControllerProvider.notifier)
                                  .getMovieListByType(
                                    type: MovieListType.nowPlaying,
                                  );
                            },
                            style: theme.textButtonTheme.style?.copyWith(
                                visualDensity: VisualDensity.compact,
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            child: Text(
                              Strings.tryAgain,
                              style: theme.textTheme.labelLarge?.copyWith(
                                decoration: TextDecoration.underline,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                loading: () {
                  return const PrimarySliverAppBar(
                    isLoading: true,
                    inverseColors: true,
                  );
                },
              ),
              SliverPersistentHeader(
                delegate: SliverPersistentDelegate(
                  TabBar(
                    dividerColor: theme.tabBarTheme.dividerColor,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.movie_outlined),
                        text: Strings.movies,
                      ),
                      Tab(
                        icon: Icon(Icons.local_movies_outlined),
                        text: Strings.series,
                      ),
                      Tab(
                        icon: Icon(Icons.person_pin_outlined),
                        text: Strings.actors,
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: tabs
                .map(
                  (e) => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacing.s8,
                      horizontal: Spacing.s12,
                    ),
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class MoviesTab extends ConsumerWidget {
  const MoviesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = ref.read(homeControllerProvider.notifier);
    final watch = ref.watch(homeControllerProvider);
    final read = ref.read(homeControllerProvider);
    return Column(
      children: [
        // Popular
        Row(
          children: [
            const Text(Strings.popular),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(Strings.viewAll),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const Placeholder(),
            separatorBuilder: (context, index) =>
                const SizedBox(width: Spacing.s6),
            itemCount: 5,
          ),
        ),
        // Top Rated
        Row(
          children: [
            const Text(Strings.topRated),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(Strings.viewAll),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const Placeholder(),
            separatorBuilder: (context, index) =>
            const SizedBox(width: Spacing.s6),
            itemCount: 5,
          ),
        ),
        // Trending
        Row(
          children: [
            const Text(Strings.trending),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(Strings.viewAll),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const Placeholder(),
            separatorBuilder: (context, index) =>
            const SizedBox(width: Spacing.s6),
            itemCount: 5,
          ),
        ),
        // Upcoming
        Row(
          children: [
            const Text(Strings.upcoming),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(Strings.viewAll),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const Placeholder(),
            separatorBuilder: (context, index) =>
            const SizedBox(width: Spacing.s6),
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}

class SeriesTab extends StatelessWidget {
  const SeriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ActorsTab extends StatelessWidget {
  const ActorsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
