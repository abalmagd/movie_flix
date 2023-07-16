import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/presentation/riverpod/movies/movies_controller.dart';
import 'package:movie_flix/features/home/presentation/riverpod/persons/persons_controller.dart';
import 'package:movie_flix/features/home/presentation/riverpod/series/series_controller.dart';
import 'package:movie_flix/features/home/presentation/shimmer_placeholders/media_poster_shimmer.dart';
import 'package:movie_flix/features/home/presentation/widgets/media_poster.dart';
import 'package:movie_flix/features/home/presentation/widgets/person_poster.dart';
import 'package:movie_flix/features/home/presentation/widgets/sliver_delegates.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/drawer/primary_drawer.dart';
import 'package:movie_flix/shared/presentation/primary_sliver_appbar.dart';
import 'package:movie_flix/utils/strings.dart';

import '../../../config/theme/palette.dart';
import '../../../shared/presentation/frosted_container.dart';

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
    const PeopleTab(),
  ];

  late final CarouselController _textCarouselController;
  late final CarouselController _backdropCarouselController;
  bool isScrolling = false;

  @override
  void initState() {
    super.initState();

    _textCarouselController = CarouselController();
    _backdropCarouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final watch = ref.watch(moviesControllerProvider);
    return Scaffold(
      drawer: const PrimaryDrawer(),
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              watch.nowPlaying.when(
                data: (movies) {
                  return PrimarySliverAppBar(
                    collapsedTitle: FrostedContainer(
                      child: Text(
                        Strings.home,
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: Palette.white),
                      ),
                    ),
                    expandedTitle: CarouselSlider(
                      carouselController: _textCarouselController,
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        autoPlayInterval: const Duration(seconds: 10),
                        autoPlayCurve: Curves.ease,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          _backdropCarouselController.animateToPage(
                            index,
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 1500),
                          );
                        },
                      ),
                      items: movies.map(
                        (movie) {
                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FrostedContainer(
                                    blurStrength: 6,
                                    child: Text(
                                      Strings.inTheaters,
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(color: Palette.white),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  FrostedContainer(
                                    blurStrength: 6,
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
                            ),
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
                            '${RemoteEnvironment.tmdbImage}${RemoteEnvironment.backdropQuality}${movie.backdropPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            filterQuality: FilterQuality.none,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  .read(moviesControllerProvider.notifier)
                                  .getNowPlaying();
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
                        text: Strings.people,
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: tabs.map((tab) => tab).toList(),
          ),
        ),
      ),
    );
  }
}

class MoviesTab extends ConsumerWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = ref.read(moviesControllerProvider.notifier);
    final watch = ref.watch(moviesControllerProvider);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        // Popular
        ViewAll(title: Strings.popular, onPressed: () {}),
        watch.popular.when(
          data: (movies) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) => MediaPoster(
                  media: movies[index],
                  state: watch,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: movies.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getPopular());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Top Rated
        ViewAll(title: Strings.topRated, onPressed: () {}),
        watch.topRated.when(
          data: (movies) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) => MediaPoster(
                  media: movies[index],
                  state: watch,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: movies.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getTopRated());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Trending
        ViewAll(title: Strings.trending, onPressed: () {}),
        watch.trending.when(
          data: (movies) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) => MediaPoster(
                  media: movies[index],
                  state: watch,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: movies.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getTrending());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Upcoming
        ViewAll(title: Strings.upcoming, onPressed: () {}),
        watch.upcoming.when(
          data: (movies) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) => MediaPoster(
                  media: movies[index],
                  state: watch,
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: movies.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getUpcoming());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
      ],
    );
  }
}

class SeriesTab extends ConsumerWidget {
  const SeriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = ref.read(seriesControllerProvider.notifier);
    final watch = ref.watch(seriesControllerProvider);
    // final watch = ref.watch(seriesControllerProvider);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        // Popular
        ViewAll(title: Strings.popular, onPressed: () {}),
        watch.popular.when(
          data: (series) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) =>
                    MediaPoster(media: series[index], state: watch),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: series.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getPopular());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Top Rated
        ViewAll(title: Strings.topRated, onPressed: () {}),
        watch.topRated.when(
          data: (series) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) =>
                    MediaPoster(media: series[index], state: watch),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: series.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getTopRated());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Trending
        ViewAll(title: Strings.trending, onPressed: () {}),
        watch.trending.when(
          data: (series) {
            return SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) =>
                    MediaPoster(media: series[index], state: watch),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: series.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getTrending());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
      ],
    );
  }
}

class PeopleTab extends ConsumerWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = ref.read(personsControllerProvider.notifier);
    final watch = ref.watch(personsControllerProvider);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: [
        // Popular
        ViewAll(title: Strings.popular, onPressed: () {}),
        watch.popular.when(
          data: (persons) {
            return SizedBox(
              height: 225,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) =>
                    PersonPoster(person: persons[index]),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: persons.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getPopular());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        ),
        // Trending
        ViewAll(title: Strings.trending, onPressed: () {}),
        watch.trending.when(
          data: (persons) {
            return SizedBox(
              height: 225,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) =>
                    PersonPoster(person: persons[index]),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: persons.length,
              ),
            );
          },
          error: (_, __) {
            return ErrorText(onRetry: () => call.getTrending());
          },
          loading: () {
            return const SizedBox(height: 200, child: MediaPosterShimmer());
          },
        )
      ],
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.error,
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onRetry,
          child: Text(
            Strings.tryAgain,
            style: theme.textTheme.labelLarge?.copyWith(
              decoration: TextDecoration.underline,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class ViewAll extends StatelessWidget {
  const ViewAll({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: const Text(Strings.viewAll),
          ),
        ],
      ),
    );
  }
}
