import 'package:flutter/material.dart';
import 'package:weather_app/common/dialogs/dialog_view/dialog_view.dart';

class DialogProvider {
  DialogProvider._();

  static final DialogProvider instance = DialogProvider._();
  bool expiredTokenIsShowing = false;

  Widget _mainDialog({Widget? child, Color? backgroundColor, EdgeInsets insetPadding = const EdgeInsets.all(16)}) {
    return Dialog(
      elevation: 0,
      insetPadding: insetPadding,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }

  showConfirmDialog(
    BuildContext context, {
    required String message,
    String? title,
    String positiveTitle = 'OK',
    String? negativeTitle,
    Function()? positiveCallback,
    Function()? negativeCallback,
    bool barrierDismissible = true,
  }) {
    if (expiredTokenIsShowing || message.isEmpty) return;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return PopScope(
          canPop: barrierDismissible,
          child: _mainDialog(
            child: DialogView(
              message: message,
              title: title,
              positiveTitle: positiveTitle,
              positiveCallback: positiveCallback,
              negativeTitle: negativeTitle,
              negativeCallback: negativeCallback,
            ),
          ),
        );
      },
    );
  }
}
