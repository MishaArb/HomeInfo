part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeInitEvent extends ThemeEvent{}
class ThemeLightEvent extends ThemeEvent{}
class ThemeDarkEvent extends ThemeEvent{}
class ThemeSystemEvent extends ThemeEvent{}
