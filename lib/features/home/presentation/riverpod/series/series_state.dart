import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/genre.dart';
import '../../../domain/media.dart';

@immutable
class SeriesState extends Equatable {
  const SeriesState({
    required this.popular,
    required this.topRated,
    required this.trending,
    required this.genres,
  });

  final AsyncValue<List<Media>> popular;
  final AsyncValue<List<Media>> topRated;
  final AsyncValue<List<Media>> trending;
  final AsyncValue<List<Genre>> genres;

  SeriesState copyWith({
    AsyncValue<List<Media>>? popular,
    AsyncValue<List<Media>>? topRated,
    AsyncValue<List<Media>>? trending,
    AsyncValue<List<Genre>>? genres,
  }) {
    return SeriesState(
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
      trending: trending ?? this.trending,
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [
        popular,
        topRated,
        trending,
        genres,
      ];
}
