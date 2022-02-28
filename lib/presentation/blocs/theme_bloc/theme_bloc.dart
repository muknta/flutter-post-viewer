import 'package:equatable/equatable.dart';
import 'package:page_viewer/presentation/themes/dark_themes/dark_theme.dart';
import 'package:page_viewer/presentation/themes/i_theme.dart';
import 'package:page_viewer/presentation/themes/light_themes/light_theme.dart';
import 'package:page_viewer/presentation/utils/mixins/bloc_stream_mixin.dart';
import 'package:rxdart/rxdart.dart';

export 'package:page_viewer/presentation/utils/extensions/bloc_context_finder_extension.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc with BlocStreamMixin {
  ThemeBloc() {
    _eventController.listen(_handleEvent);
  }

  final _eventController = BehaviorSubject<ThemeEvent>();
  Function(ThemeEvent) get addEvent => sinkAdd(_eventController);

  final _themeStateController = BehaviorSubject<ThemeState>.seeded(const InitThemeState(theme: DarkTheme()));
  Stream<ThemeState> get themeStateStream => _themeStateController.stream;
  Function(ThemeState) get _addState => sinkAdd(_themeStateController);

  ITheme get theme => _themeStateController.value.theme is DarkTheme ? const LightTheme() : const DarkTheme();

  void _handleEvent(ThemeEvent event) {
    if (event is ChangeThemeEvent) {
      _addState(ChangeThemeState(theme: event.theme));
    }
  }

  @override
  void dispose() {
    if (isStreamNotClosed(_eventController)) {
      _eventController.close();
    }
    if (isStreamNotClosed(_themeStateController)) {
      _themeStateController.close();
    }
  }
}
