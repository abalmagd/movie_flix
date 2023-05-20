import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/remote/api/home/home_service.dart';

import 'home_state.dart';

final homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, HomeState>(
  (ref) {
    return HomeController(
      const HomeState(),
      ref.watch(baseHomeServiceProvider),
    );
  },
);

class HomeController extends StateNotifier<HomeState> {
  HomeController(HomeState state, this._homeService) : super(state);

  final BaseHomeService _homeService;

  @override
  void dispose() {
    /*Comment to hide warning*/
    super.dispose();
  }
}
