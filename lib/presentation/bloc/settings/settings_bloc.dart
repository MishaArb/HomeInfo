import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share_plus/share_plus.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsInitEvent>(_onInit);
    on<SettingsGoToReminderScreenEvent>(_onGoToRemindersScreen);
    on<SettingsGoToThemeScreenEvent>(_onGoToThemeScreen);
    on<SettingsGoToLanguageScreenEvent>(_onGoToLanguageScreen);
    on<SettingsGoToCurrencyScreenEvent>(_onGoToCurrencyScreen);
    on<SettingsFeedbackEvent>(_onFeedback);
    on<SettingsShareAppEvent>(_onShareApp);
    on<SettingsRateAppEvent>(_onRateApp);
  }

  _onInit(SettingsInitEvent event, Emitter<SettingsState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: packageInfo.version));
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

  _onFeedback(SettingsFeedbackEvent event, Emitter<SettingsState> emit) async {
    final Email email = Email(
      body: '',
      subject: 'HomeInfo',
      recipients: ['easyspaceg@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  _onShareApp(SettingsShareAppEvent event, Emitter<SettingsState> emit) {
    Share.share(
        'https://play.google.com/store/apps/details?id=com.easyspaceg.homeinfo.home_info');
  }

  _onRateApp(SettingsRateAppEvent event, Emitter<SettingsState> emit) async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
