import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meta/meta.dart';
import '../../../core/constants/settings_theme.dart';
import '../../../domain/repository/storage_repository.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this.storageRepository) : super(const ThemeState()) {
    on<ThemeInitEvent>(_onInitTheme);
    on<ThemeLightEvent>(_onChangeLightTheme);
    on<ThemeDarkEvent>(_onChangeDarkTheme);
    on<ThemeSystemEvent>(_onChangeSystemTheme);
  }

  final StorageRepository storageRepository;

  _onInitTheme(ThemeInitEvent event, Emitter<ThemeState> emit) async {
    final platformBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final bool isLight = await storageRepository
        .loadStorageData(SettingsTheme.lightTheme, defaultValue: true);
    final bool isDark = await storageRepository
        .loadStorageData(SettingsTheme.darkTheme, defaultValue: false);
    final bool isSystem = await storageRepository
        .loadStorageData(SettingsTheme.systemTheme, defaultValue: false);
    final ThemeMode currentTheme = isDark
        ? ThemeMode.dark
        : isLight
            ? ThemeMode.light
            : platformBrightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark;
    emit(
      ThemeState(
        currentTheme: currentTheme,
        isLightTheme: isLight,
        isDarkTheme: isDark,
        isSystemTheme: isSystem,
      ),
    );
  }

  _onChangeLightTheme(ThemeLightEvent event, Emitter<ThemeState> emit) {
    _saveThemeSettings(isLight: true, isDark: false, isSystem: false);
    emit(
      const ThemeState(
        currentTheme: ThemeMode.light,
        isLightTheme: true,
        isDarkTheme: false,
        isSystemTheme: false,
      ),
    );
  }

  _onChangeDarkTheme(ThemeDarkEvent event, Emitter<ThemeState> emit) {
    _saveThemeSettings(isLight: false, isDark: true, isSystem: false);
    emit(
      const ThemeState(
        currentTheme: ThemeMode.dark,
        isLightTheme: false,
        isDarkTheme: true,
        isSystemTheme: false,
      ),
    );
  }

  _onChangeSystemTheme(ThemeSystemEvent event, Emitter<ThemeState> emit) {
    final platformBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _saveThemeSettings(isLight: false, isDark: false, isSystem: true);
    final ThemeMode currentTheme = platformBrightness == Brightness.light
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(
      ThemeState(
        currentTheme: currentTheme,
        isLightTheme: false,
        isDarkTheme: false,
        isSystemTheme: true,
      ),
    );
  }

  _saveThemeSettings(
      {required bool isLight, required bool isDark, required bool isSystem}) {
    storageRepository.saveStorageData(SettingsTheme.lightTheme, isLight);
    storageRepository.saveStorageData(SettingsTheme.darkTheme, isDark);
    storageRepository.saveStorageData(SettingsTheme.systemTheme, isSystem);
  }
}
