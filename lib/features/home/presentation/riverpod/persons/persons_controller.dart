import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/persons/persons_service.dart';
import '../../../domain/person.dart';

final personsControllerProvider =
    AsyncNotifierProvider<PersonsController, List<Person>>(
        PersonsController.new);

class PersonsController extends AsyncNotifier<List<Person>> {
  late final BasePersonsService _personsService;

  @override
  FutureOr<List<Person>> build() async {
    _personsService = ref.read(basePersonsServiceProvider);

    final result = await _personsService.getPopular();

    late final List<Person> persons;

    result.fold(
      (failure) => persons = [],
      (personsList) => persons = personsList,
    );

    return persons;
  }

  Future<void> getPopular({int page = 1}) async {
    state = const AsyncLoading();

    final result = await _personsService.getPopular();

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (persons) => state = AsyncData(persons),
    );
  }
}
