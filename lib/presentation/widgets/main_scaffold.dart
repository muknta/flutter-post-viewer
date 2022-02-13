import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/utils/extensions/bloc_context_finder_extension.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key, required String title, required Widget body, void Function()? onTapBackButton})
      : _title = title,
        _body = body,
        _onTapBackButton = onTapBackButton,
        super(key: key);

  final String _title;
  final Widget _body;
  final void Function()? _onTapBackButton;

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
          leading: widget._onTapBackButton != null
              // TODO: add backButton
              ? const SizedBox.shrink()
              : const SizedBox.shrink(),
          title: Text(widget._title),
          backgroundColor: _mainTheme.appBarBackgroundColor,
          foregroundColor: _mainTheme.appBarTextColor,
        ),
        body: widget._body,
      );
}
