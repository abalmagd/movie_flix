import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ConfigState extends Equatable {
  const ConfigState({
    this.themeMode = ThemeMode.dark,
  });

  final ThemeMode themeMode;

  ConfigState copyWith({
    ThemeMode? themeMode,
  }) {
    return ConfigState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
      ];
}
