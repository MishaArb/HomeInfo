part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final String appVersion;

  const SettingsState({this.appVersion = ''});

  SettingsState copyWith({
    String? appVersion,
  }) {
    return SettingsState(appVersion: appVersion ?? this.appVersion);
  }
}


