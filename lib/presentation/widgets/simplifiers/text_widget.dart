import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_viewer/presentation/utils/extensions/capitalize_string_extension.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    String text, {
    Key? key,
    bool isCapitalized = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
  })  : _text = text,
        _isCapitalized = isCapitalized,
        _color = color,
        _backgroundColor = backgroundColor,
        _fontSize = fontSize,
        _textAlign = textAlign,
        _maxLines = maxLines,
        super(key: key);

  final String _text;
  final bool _isCapitalized;
  final Color? _color;
  final Color? _backgroundColor;
  final double? _fontSize;
  final TextAlign? _textAlign;
  final int? _maxLines;

  @override
  Widget build(BuildContext context) => AutoSizeText(
        _isCapitalized ? _text.capitalize() : _text,
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
