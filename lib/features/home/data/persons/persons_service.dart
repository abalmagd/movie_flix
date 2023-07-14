import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/home/data/persons/persons_repository.dart';

import '../../../../shared/domain/failure.dart';
import '../../domain/person.dart';

abstract class BasePersonsService {
  Future<Either<Failure, List<Person>>> getPopular();

  Future<Either<Failure, List<Person>>> getTrending();
}

final basePersonsServiceProvider = Provider<BasePersonsService>((ref) {
  return PersonsService(ref.watch(basePersonsRepositoryProvider));
});

class PersonsService implements BasePersonsService {
  PersonsService(this._basePersonsRepository);

  final BasePersonsRepository _basePersonsRepository;

  @override
  Future<Either<Failure, List<Person>>> getPopular() async {
    try {
      final json = await _basePersonsRepository.getPopular();

      final results = json['results'] as List;

      final persons = results.map((person) => Person.fromJson(person)).toList();

      return Right(persons);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Person>>> getTrending() async {
    try {
      final json = await _basePersonsRepository.getTrending();

      final results = json['results'] as List;

      final persons = results.map((person) => Person.fromJson(person)).toList();

      return Right(persons);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
