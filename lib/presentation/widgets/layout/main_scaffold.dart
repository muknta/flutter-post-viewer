import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_main_theme.dart';
import 'package:page_viewer/presentation/widgets/simplifiers/loader.dart';

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
  late final ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = context.readBloc<ThemeBloc>();
    _mainTheme = _themeBloc.theme.mainTheme;
  }

  @override
  Widget build(BuildContext context) =>
      StreamBuilder(stream: _themeBloc.themeStateStream, builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Loader();
  }
 return Scaffold(
        backgroundColor: _mainTheme.backgroundColor,
        appBar: AppBar(
          leading: widget._onBackButtonTap != null
              ? BackButton(
                  color: _mainTheme.appBarTextColor,
                  onPressed: widget._onBackButtonTap,
                )
              : null,
          title: Text(widget._title),
          actions: [
            IconButton(
              icon: const Icon(Icons.airplay_rounded),
              onPressed: _themeBloc.addEvent(const ChangeThemeEvent()),),

          ],
          backgroundColor: _mainTheme.appBarBackgroundColor,
          foregroundColor: _mainTheme.appBarTextColor,
        ),
        body: widget._body,
      );
}
