import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/person.dart';

@immutable
class PersonsState extends Equatable {
  const PersonsState({
    this.popular = const AsyncData([]),
    this.trending = const AsyncData([]),
  });

  final AsyncValue<List<Person>> popular;
  final AsyncValue<List<Person>> trending;

  PersonsState copyWith({
    AsyncValue<List<Person>>? popular,
    AsyncValue<List<Person>>? trending,
  }) {
    return PersonsState(
      popular: popular ?? this.popular,
      trending: trending ?? this.trending,
    );
  }

  @override
  List<Object?> get props => [popular, trending];
}
