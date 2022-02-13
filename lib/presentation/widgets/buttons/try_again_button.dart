import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/widgets/buttons/standard_center_button.dart';

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    Key? key,
    required void Function() onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final void Function() _onPressed;

  static const String _title = 'Try again';

  @override
  Widget build(BuildContext context) => StandardCenterButton(onPressed: _onPressed, title: _title);
}
