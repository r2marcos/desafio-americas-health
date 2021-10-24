import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class WidgetUtils {
  static ProgressDialog buildProgressDialog(BuildContext context,
      {String? message}) {
    final pd = ProgressDialog(
      context,
      isDismissible: false,
    );
    pd.style(
      message: message ?? 'Please wait...',
      borderRadius: 10,
      progressWidget: const Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),
      ),
    );
    return pd;
  }
}
