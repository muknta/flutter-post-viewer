import 'package:page_viewer/presentation/themes/dark_themes/buttons_dark_theme.dart';
import 'package:page_viewer/presentation/themes/dark_themes/main_dark_theme.dart';
import 'package:page_viewer/presentation/themes/dark_themes/post_list_dark_theme.dart';
import 'package:page_viewer/presentation/themes/dark_themes/post_page_dark_theme.dart';
import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_page_theme.dart';
import 'package:page_viewer/presentation/themes/i_theme.dart';

class DarkTheme implements ITheme {
  const DarkTheme();

  @override
  IMainTheme get mainTheme => const MainDarkTheme();

  @override
  IButtonsTheme get buttonsTheme => const ButtonsDarkTheme();

  @override
  IPostListTheme get postListTheme => const PostListDarkTheme();

  @override
  IPostPageTheme get postPageTheme => const PostPageDarkTheme();
}
