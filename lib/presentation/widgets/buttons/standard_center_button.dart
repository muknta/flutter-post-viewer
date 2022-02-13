import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:page_viewer/presentation/themes/i_buttons_theme.dart';

class StandardCenterButton extends StatelessWidget {
  const StandardCenterButton({
    Key? key,
    required void Function() onPressed,
    String title = 'Press me',
  })  : _onPressed = onPressed,
        _title = title,
        super(key: key);

  final void Function() _onPressed;
  final String _title;

  @override
  Widget build(BuildContext context) {
    final IButtonsTheme buttonsTheme = context.readBloc<ThemeBloc>().theme.buttonsTheme;
    return Center(
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonsTheme.pressedButtonBackgroundColor;
            }
            return buttonsTheme.backgroundColor;
          }),
          foregroundColor: MaterialStateProperty.all<Color>(buttonsTheme.foregroundColor),
        ),
        child: Text(_title),
      ),
    );
  }
}
