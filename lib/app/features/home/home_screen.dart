import 'package:flutter/material.dart';
import 'package:movie_flix/app/environment/strings.dart';
import 'package:movie_flix/app/widgets/primary_drawer.dart';

import '../../environment/spacing.dart';
import '../../widgets/primary_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  final List<Widget> tabs = [
    const MoviesTab(),
    const SeriesTab(),
    const ActorsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(title: Strings.home),
      drawer: const PrimaryDrawer(),
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            const TabBar(
              tabs: [
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
            Expanded(
              child: TabBarView(children: tabs),
            ),
          ],
        ),
      ),
    );
  }
}

class MoviesTab extends StatelessWidget {
  const MoviesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.s12),
      child: Column(
        children: [
          /*Latest*/
          Row(
            children: [
              const Text(Strings.latest),
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
          /*Trending*/
          Row(
            children: [
              const Text(Strings.trending),
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
          /*Upcoming*/
          Row(
            children: [
              const Text(Strings.upcoming),
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
      ),
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
