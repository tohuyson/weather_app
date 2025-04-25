import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/styles.dart';

class TodayComponent extends StatelessWidget {
  const TodayComponent({super.key, required this.temperature, required this.location});

  final int temperature;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$temperature°', style: UITextStyle.black.copyWith(fontSize: 96, height: 1.2)),
        Text(location, style: UITextStyle.thin.copyWith(fontSize: 36, color: UIColors.secondaryText, height: 1.4)),
      ],
    );
  }
}
