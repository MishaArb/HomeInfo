part of 'locale_bloc.dart';


class LocaleState  extends Equatable {
  final bool isUkrainian;
  final bool isEnglish;
  final Locale currentLocale;

  const LocaleState({
      this.currentLocale = const Locale(SettingsLocale.english),
      this.isUkrainian = false,
      this.isEnglish = true,
  });

  @override
  List<Object?> get props => [isUkrainian, isEnglish, currentLocale];
}

