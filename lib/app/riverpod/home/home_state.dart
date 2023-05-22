import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/models/auth/session.dart';

@immutable
class HomeState extends Equatable {
  const HomeState();

  HomeState copyWith({
    AsyncValue<Session>? session,
  }) {
    return HomeState();
  }

  @override
  List<Object?> get props => [];
}
