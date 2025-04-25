import 'package:flutter/material.dart';

import '../colors.dart';
import '../styles.dart';

Widget _defaultLoadingWidget = const SizedBox(
  width: 20,
  height: 20,
  child: RepaintBoundary(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3.5)),
);

class _RenderButton extends StatelessWidget {
  _RenderButton({
    this.title,
    this.widget,
    required this.onPressed,
    this.enabled = true,
    this.buttonColor,
    this.textColor = UIColors.white,
    this.padding = const EdgeInsets.all(13),
    this.isLoading = false,
    this.height,
    this.width,
    this.radius = 6,
  });

  final String? title;
  final Widget? widget;
  final bool enabled;
  final void Function() onPressed;
  final Color? buttonColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double? height;
  final double? width;
  final double radius;

  late final Widget button = MaterialButton(
    onPressed:
        enabled
            ? () {
              if (!isLoading) {
                onPressed();
              }
            }
            : null,
    padding: padding,
    color: buttonColor ?? UIColors.primaryColor,
    splashColor: enabled ? null : Colors.transparent,
    highlightColor: enabled ? null : Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    child:
        isLoading
            ? _defaultLoadingWidget
            : Text(
              title ?? "",
              textAlign: TextAlign.center,
              style: UITextStyle.medium.copyWith(color: enabled ? textColor : null, height: 1.2),
            ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width, child: button);
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.title,
    this.widget,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.buttonColor = UIColors.backgroundBtn,
    this.textColor = UIColors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.height = 48,
    this.width,
    this.radius = 0,
  });

  final String? title;
  final Widget? widget;
  final bool enabled;
  final void Function() onPressed;
  final Color? buttonColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return _RenderButton(
      title: title,
      widget: widget,
      onPressed: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
        onPressed();
      },
      enabled: enabled,
      buttonColor: buttonColor,
      textColor: textColor,
      padding: padding,
      isLoading: isLoading,
      height: height,
      width: width,
      radius: radius,
    );
  }
}
