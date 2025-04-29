import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/styles.dart';

class DialogView extends StatelessWidget {
  const DialogView({
    super.key,
    required this.message,
    this.title,
    this.positiveTitle = 'OK',
    this.positiveCallback,
    this.negativeTitle,
    this.negativeCallback,
  });

  final String message;
  final String? title;
  final String positiveTitle;
  final String? negativeTitle;
  final Function()? positiveCallback;
  final Function()? negativeCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Text(title!, style: UITextStyle.bold.copyWith(fontSize: 20, color: UIColors.defaultText)),
                ),
              Text(
                message,
                style: UITextStyle.regular.copyWith(fontSize: 15, color: UIColors.defaultText),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Row(
          children: [
            if (negativeTitle != null)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pop();
                    negativeCallback?.call();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      negativeTitle!,
                      style: UITextStyle.regular.copyWith(fontSize: 18, color: UIColors.defaultText),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).pop();
                  positiveCallback?.call();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    positiveTitle,
                    style: UITextStyle.semiBold.copyWith(fontSize: 18, color: UIColors.defaultText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
