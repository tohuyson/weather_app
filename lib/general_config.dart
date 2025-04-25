import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'di/get_it.dart';
import 'env_data.dart';

EventBus eventBus = EventBus();

class GeneralConfig {
  GeneralConfig._();

  static init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await EnvData.instance.getEnvData();
    await configureDependencies();
  }
}
