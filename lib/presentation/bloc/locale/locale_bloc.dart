import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/constants/settings_locale.dart';
import '../../../domain/repository/storage_repository.dart';
import 'dart:io' show Platform;

part 'locale_event.dart';

part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(this.storageRepository) : super(const LocaleState()) {
    on<LocaleInitEvent>(_onInitLanguage);
    on<LocaleChangeEvent>(_onChangeLanguage);
  }

  final StorageRepository storageRepository;

  _onInitLanguage(LocaleInitEvent event, Emitter<LocaleState> emit) async {
    String localeCode = _checkLocale();
    String languageCode = await storageRepository.loadStorageData(
      SettingsLocale.languageKey,
      defaultValue: localeCode,
    );
    emit(
      LocaleState(
        isUkrainian: languageCode == SettingsLocale.ukrainian ? true : false,
        isEnglish: languageCode == SettingsLocale.english ? true : false,
        currentLocale: Locale(languageCode),
      ),
    );
  }

  _onChangeLanguage(LocaleChangeEvent event, Emitter<LocaleState> emit) async {
  await storageRepository.saveStorageData(
        SettingsLocale.languageKey, event.localeCode);
    emit(
      LocaleState(
        isUkrainian: event.localeCode == SettingsLocale.ukrainian ? true : false,
        isEnglish: event.localeCode == SettingsLocale.english ? true : false,
        currentLocale: Locale(event.localeCode),
      ),
    );
  }

  _checkLocale() {
    final String systemLocale = Platform.localeName.split('_')[0];
    if (SettingsLocale.ukrainian == systemLocale) {
      return systemLocale;
    } else if (systemLocale == 'ru') {
      return SettingsLocale.ukrainian;
    } else {
      return SettingsLocale.english;
    }
  }
}
