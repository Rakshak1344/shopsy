import 'package:app/config/shopsy_app_config.dart';
import 'package:app/shopsy_app.dart';
import 'package:app/splash_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SplashApp());

  ShopsyAppConfig().init(child: const ShopsyApp()).then((widget) {
    runApp(widget);
  });
}
