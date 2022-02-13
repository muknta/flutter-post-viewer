import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_page_theme.dart';

abstract class ITheme {
  const ITheme();

  IMainTheme get mainTheme;

  IButtonsTheme get buttonsTheme;

  IPostListTheme get postListTheme;

  IPostPageTheme get postPageTheme;
}
