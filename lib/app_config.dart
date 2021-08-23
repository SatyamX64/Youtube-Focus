import 'dart:html';

import 'package:flutter/cupertino.dart';

// To send configs/dependencies from main.dart to MyApp 
class AppConfig extends InheritedWidget {
  final String appName;
  final String initialRoute;

  AppConfig({
    required this.appName,
    required this.initialRoute,
    required Widget child,
  }) : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
