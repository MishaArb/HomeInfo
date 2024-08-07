import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsInitEvent>(_onInit);
    on<SettingsGoToReminderScreenEvent>(_onGoToRemindersScreen);
    on<SettingsGoToThemeScreenEvent>(_onGoToThemeScreen);
    on<SettingsGoToLanguageScreenEvent>(_onGoToLanguageScreen);
    on<SettingsGoToCurrencyScreenEvent>(_onGoToCurrencyScreen);
  }

  _onInit(SettingsInitEvent event, Emitter<SettingsState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: packageInfo.version ));
  }

  _onGoToRemindersScreen(
      SettingsGoToReminderScreenEvent event, Emitter<SettingsState> emit) {
    event.context.router.pushNamed('/remindersScreen');
  }

  _onGoToThemeScreen(
      SettingsGoToThemeScreenEvent event, Emitter<SettingsState> emit) {
    event.context.router.pushNamed('/themeScreen');
  }

  _onGoToLanguageScreen(
      SettingsGoToLanguageScreenEvent event, Emitter<SettingsState> emit) {
    event.context.router.pushNamed('/languageScreen');
  }


  _onGoToCurrencyScreen(
      SettingsGoToCurrencyScreenEvent event, Emitter<SettingsState> emit) {
    event.context.router.pushNamed('/currencyScreen');
  }
}
