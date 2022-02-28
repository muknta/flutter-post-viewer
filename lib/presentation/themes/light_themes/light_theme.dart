import 'package:page_viewer/presentation/themes/light_themes/buttons_light_theme.dart';
import 'package:page_viewer/presentation/themes/light_themes/main_light_theme.dart';
import 'package:page_viewer/presentation/themes/light_themes/post_list_light_theme.dart';
import 'package:page_viewer/presentation/themes/light_themes/post_page_light_theme.dart';
import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_list_theme.dart';
import 'package:page_viewer/presentation/themes/i_post_page_theme.dart';
import 'package:page_viewer/presentation/themes/i_theme.dart';

class LightTheme implements ITheme {
  const LightTheme();

  @override
  IMainTheme get mainTheme => const MainLightTheme();

  @override
  IButtonsTheme get buttonsTheme => const ButtonsLightTheme();

  @override
  IPostListTheme get postListTheme => const PostListLightTheme();

  @override
  IPostPageTheme get postPageTheme => const PostPageLightTheme();
}
