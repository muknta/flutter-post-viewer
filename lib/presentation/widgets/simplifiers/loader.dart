import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IMainTheme mainTheme = context.readBloc<ThemeBloc>().theme.mainTheme;
    return Center(
      child: CircularProgressIndicator(
        color: mainTheme.loaderColor,
      ),
    );
  }
}
