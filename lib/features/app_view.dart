import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/common/bloc_status.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/size.dart';
import 'package:weather_app/common/widgets/splash_screen.dart';
import 'package:weather_app/di/get_it.dart';
import 'package:weather_app/features/app_cubit.dart';
import 'package:weather_app/routes/routes.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppViewState();
  }
}

class _AppViewState extends State<AppView> {
  bool _init = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AppCubit>(create: (context) => getItInstance.get<AppCubit>())],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state.status.isInitial && !_init) {
            _init = true;
            context.read<AppCubit>().init();
          }
          if (state.status.isInitial || state.status.isLoading) {
            return SplashScreen(key: Key(state.status.name));
          }
          return SplashScreen(
            key: Key(state.status.name),
            nextScreen: GestureDetector(
              onTap: () => _dismissKeyboardOnLostFocus(context),
              child: RefreshConfiguration(
                footerTriggerDistance: _getHeightWithoutContext() * 2 / 3,
                hideFooterWhenNotFull: true,
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerDelegate: getItInstance.get<AppRouter>().delegate(),
                  routeInformationParser: getItInstance.get<AppRouter>().defaultRouteParser(),
                  theme: Theme.of(context).copyWith(scaffoldBackgroundColor: UIColors.background),
                  builder: (context, child) {
                    AppSize.instance.init(context);
                    return child ?? const SizedBox();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _dismissKeyboardOnLostFocus(BuildContext ctx) {
    final FocusScopeNode currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  _getHeightWithoutContext() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize.height / view.devicePixelRatio;
  }
}

clickedBackBtn() {
  return true;
}
