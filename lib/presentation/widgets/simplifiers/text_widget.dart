import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    String text, {
    Key? key,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
  })  : _text = text,
        _color = color,
        _backgroundColor = backgroundColor,
        _fontSize = fontSize,
        _textAlign = textAlign,
        _maxLines = maxLines,
        super(key: key);

  final String _text;
  final Color? _color;
  final Color? _backgroundColor;
  final double? _fontSize;
  final TextAlign? _textAlign;
  final int? _maxLines;

  @override
  Widget build(BuildContext context) => Text(
        _text,
        textAlign: _textAlign,
        overflow: TextOverflow.ellipsis,
        maxLines: _maxLines,
        style: TextStyle(
          color: _color,
          backgroundColor: _backgroundColor,
          fontSize: _fontSize,
        ),
      );
}
