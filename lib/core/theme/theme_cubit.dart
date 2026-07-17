import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/core/theme/theme_data_source.dart';
import 'package:news_app/core/theme/theme_states.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeDataSource dataSource = ThemeDataSource();

  ThemeCubit() : super(LightThemeState()) {
    loadTheme();
  }

  bool isDark = false;

  void loadTheme() {
    isDark = dataSource.loadTheme();

    if (isDark) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;

    await dataSource.saveTheme(isDark);

    if (isDark) {
      emit(DarkThemeState());
    } else {
      emit(LightThemeState());
    }
  }

  ThemeData get themeData {
    return isDark ? AppTheme.dark : AppTheme.light;
  }
}
