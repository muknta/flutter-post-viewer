import 'package:flutter/material.dart';
import 'package:page_viewer/internal/application.dart';
import 'package:page_viewer/internal/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();

  runApp(const Application());
}
