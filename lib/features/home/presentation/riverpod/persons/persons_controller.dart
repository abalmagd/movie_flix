import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/presentation/riverpod/persons/persons_state.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../../data/persons/persons_service.dart';

final personsControllerProvider =
    StateNotifierProvider<PersonsController, PersonsState>(
  (ref) {
    return PersonsController(
      const PersonsState(),
      ref.read(basePersonsServiceProvider),
    );
  },
);

class PersonsController extends StateNotifier<PersonsState> {
  late final BasePersonsService _personsService;

  PersonsController(PersonsState state, this._personsService) : super(state) {
    Utils.logPrint(message: 'Building $runtimeType');
    getPopular();
    getTrending();
  }

  Future<void> getPopular({int page = 1}) async {
    state = state.copyWith(popular: const AsyncLoading());

    final result = await _personsService.getPopular();

    result.fold(
      (failure) => state =
          state.copyWith(popular: AsyncError(failure, StackTrace.current)),
      (persons) => state = state.copyWith(popular: AsyncData(persons)),
    );
  }

  Future<void> getTrending({int page = 1}) async {
    state = state.copyWith(trending: const AsyncLoading());

    final result = await _personsService.getTrending();

    result.fold(
      (failure) => state =
          state.copyWith(trending: AsyncError(failure, StackTrace.current)),
      (persons) => state = state.copyWith(trending: AsyncData(persons)),
    );
  }
}
