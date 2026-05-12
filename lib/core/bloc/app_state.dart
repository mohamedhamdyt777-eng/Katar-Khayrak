import 'package:flutter/material.dart';

class AppState {
  final ThemeMode themeMode;
  final Locale locale;

  const AppState({
    this.themeMode = ThemeMode.light, // Defaulting to light for explicit toggling
    this.locale = const Locale('en'),
  });

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
