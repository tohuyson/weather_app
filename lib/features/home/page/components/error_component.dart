import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/styles.dart';
import 'package:weather_app/common/widgets/buttons.dart';

class ErrorComponent extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorComponent({super.key, required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: UIColors.backgroundError),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            errorMessage,
            style: UITextStyle.thin.copyWith(color: UIColors.white, fontSize: 54, height: 1.2),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          PrimaryButton(onPressed: onRetry, title: 'Retry'),
        ],
      ),
    );
  }
}
