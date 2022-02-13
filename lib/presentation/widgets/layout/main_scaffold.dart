import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key, required String title, required Widget body, void Function()? onBackButtonTap})
      : _title = title,
        _body = body,
        _onBackButtonTap = onBackButtonTap,
        super(key: key);

  final String _title;
  final Widget _body;
  final void Function()? _onBackButtonTap;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late final IMainTheme _mainTheme;

  @override
  void initState() {
    super.initState();
    _mainTheme = context.readBloc<ThemeBloc>().theme.mainTheme;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: _mainTheme.backgroundColor,
        appBar: AppBar(
          leading: widget._onBackButtonTap != null
              ? BackButton(
                  color: _mainTheme.appBarTextColor,
                  onPressed: widget._onBackButtonTap,
                )
              : null,
          title: Text(widget._title),
          backgroundColor: _mainTheme.appBarBackgroundColor,
          foregroundColor: _mainTheme.appBarTextColor,
        ),
        body: widget._body,
      );
}
