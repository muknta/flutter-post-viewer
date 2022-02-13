import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/widgets/buttons/standard_center_button.dart';

class LoadPostsButton extends StatelessWidget {
  const LoadPostsButton({
    Key? key,
    required void Function() onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final void Function() _onPressed;

  static const String _title = 'Load posts';

  @override
  Widget build(BuildContext context) => StandardCenterButton(onPressed: _onPressed, title: _title);
}
