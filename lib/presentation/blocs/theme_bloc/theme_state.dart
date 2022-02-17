part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  final ITheme theme;

  @override
  List<Object?> get props => [theme];
}

class InitThemeState extends ThemeState {
  const InitThemeState({required ITheme theme}) : super(theme: theme);
}

class ChangeThemeState extends ThemeState {
  const ChangeThemeState({required ITheme theme}) : super(theme: theme);
}
