import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BlocContextFinderExtension on BuildContext {
  /// Just reads bloc for once
  T readBloc<T>() => Provider.of<T>(this, listen: false);

  /// Adds ability to listen bloc
  T watchBloc<T>() => Provider.of<T>(this, listen: true);
}
