part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent({required this.theme});

  final ITheme theme;

  @override
  List<Object> get props => [theme];
}

class ChangeThemeEvent extends ThemeEvent {
  const ChangeThemeEvent({required ITheme theme}) : super(theme: theme);
}
