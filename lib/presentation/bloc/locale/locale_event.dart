part of 'locale_bloc.dart';

@immutable
abstract class LocaleEvent {}
class LocaleInitEvent  extends LocaleEvent{}
class LocaleChangeEvent  extends LocaleEvent{
  final String localeCode;
  LocaleChangeEvent(this.localeCode);
}
