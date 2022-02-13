import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    String text, {
    Key? key,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
  })  : _text = text,
        _color = color,
        _backgroundColor = backgroundColor,
        _fontSize = fontSize,
        super(key: key);

  final String _text;
  final Color? _color;
  final Color? _backgroundColor;
  final double? _fontSize;

  @override
  Widget build(BuildContext context) => Text(
        _text,
        style: TextStyle(
          color: _color,
          backgroundColor: _backgroundColor,
          fontSize: _fontSize,
        ),
      );
}
