part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final bool isLightTheme;
  final bool isDarkTheme;
  final bool isSystemTheme;
  final ThemeMode currentTheme;

  const ThemeState({
    this.currentTheme = ThemeMode.light,
    this.isLightTheme = true,
    this.isDarkTheme = false,
    this.isSystemTheme = false,
  });

  @override
  List<Object> get props => [isLightTheme, isDarkTheme, isSystemTheme, currentTheme];
}
