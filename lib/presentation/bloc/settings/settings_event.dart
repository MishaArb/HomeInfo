part of 'settings_bloc.dart';

class SettingsEvent {
  final BuildContext context;

  SettingsEvent(this.context);
}

class SettingsInitEvent extends SettingsEvent {
  SettingsInitEvent(super.context);
}

class SettingsGoToReminderScreenEvent extends SettingsEvent {
  SettingsGoToReminderScreenEvent(super.context);
}

class SettingsGoToThemeScreenEvent extends SettingsEvent {
  SettingsGoToThemeScreenEvent(super.context);
}

class SettingsGoToLanguageScreenEvent extends SettingsEvent {
  SettingsGoToLanguageScreenEvent(super.context);
}

class SettingsGoToCurrencyScreenEvent extends SettingsEvent {
  SettingsGoToCurrencyScreenEvent(super.context);
}

class SettingsFeedbackEvent extends SettingsEvent {
  SettingsFeedbackEvent(super.context);
}

class SettingsShareAppEvent extends SettingsEvent {
  SettingsShareAppEvent(super.context);
}
