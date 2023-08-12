import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/details/domain/media_details.dart';

@immutable
class MediaDetailsState extends Equatable {
  const MediaDetailsState({
    required this.mediaDetails,
  });

  final AsyncValue<MediaDetails> mediaDetails;

  MediaDetailsState copyWith({
    AsyncValue<MediaDetails>? mediaDetails,
  }) {
    return MediaDetailsState(
      mediaDetails: mediaDetails ?? this.mediaDetails,
    );
  }

  @override
  List<Object?> get props => [mediaDetails];
}
