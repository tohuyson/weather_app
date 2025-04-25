import 'package:flutter/material.dart';
import 'package:weather_app/features/app_view.dart';
import 'package:weather_app/general_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeneralConfig.init();
  runApp(const AppView());
}
