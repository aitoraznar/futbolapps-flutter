import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// ignore: must_be_immutable
class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiBaseUrl,
    @required this.modules,
    @required this.api,
    @required Widget child,
  }) : super(child: child);

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
  var modules;
  var api;

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}