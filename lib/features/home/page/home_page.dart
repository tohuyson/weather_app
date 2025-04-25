import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/features/home/page/components/nextday_component.dart';
import 'package:weather_app/features/home/page/components/today_component.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(color: UIColors.background),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 56),
              TodayComponent(temperature: 25, location: 'New York'),
              SizedBox(height: 62),
              Expanded(
                child: NextDayComponent(
                  nextDays: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
