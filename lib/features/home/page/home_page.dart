import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/bloc_status.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/widgets/loading.dart';
import 'package:weather_app/common/widgets/loadmore_widget.dart';
import 'package:weather_app/features/home/cubit/weather/weather_cubit.dart';
import 'package:weather_app/features/home/page/components/error_component.dart';
import 'package:weather_app/features/home/page/components/nextday_component.dart';
import 'package:weather_app/features/home/page/components/today_component.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => WeatherCubit()..initFetchData(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LoadMoreWidget(
          onRefresh: () {
            return context.read<WeatherCubit>().initFetchData(isLoading: false);
          },
          child: Container(
            decoration: BoxDecoration(color: UIColors.background),
            width: double.infinity,
            child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state.status.showLoading) {
                  return LoadingWidget();
                }

                if (state.status.isFailure) {
                  return ErrorComponent(
                    errorMessage: 'Something went wrong at out end!',
                    onRetry: () {
                      context.read<WeatherCubit>().initFetchData();
                    },
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 56),
                    TodayComponent(
                      temperature: state.currentWeather?.main?.temp ?? 0,
                      location: state.currentWeather?.sys?.country ?? 'Unknown',
                    ),
                    SizedBox(height: 62),
                    Expanded(child: NextDayComponent(averageTempNextFourDays: state.averageTempNextFourDays)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
