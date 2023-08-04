import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/media.dart';

@immutable
class MediaDetailsState extends Equatable {
  const MediaDetailsState({
    required this.mediaDetails,
  });

  final AsyncValue<Media> mediaDetails;

  MediaDetailsState copyWith({
    AsyncValue<Media>? mediaDetails,
  }) {
    return MediaDetailsState(
      mediaDetails: mediaDetails ?? this.mediaDetails,
    );
  }

  @override
  List<Object?> get props => [mediaDetails];
}
