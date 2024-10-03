import 'package:flutter/material.dart';

class SnackbarHelper {
  static showTemplated(
    BuildContext context, {
    // Leading
    Widget? leading,
    // Main Content
    required String title,
    String? message,
    Widget? content,
    // Trailing
    Widget? trailing,
    // Custom style
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    SnackBarAction? action,
    Duration? duration,
  }) {
    final snackBarContent = Row(
      children: [
        if (leading != null) leading,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (message != null)
                Text(
                  message,
                  style: messageStyle ?? const TextStyle(),
                ),
              if (content != null) content,
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );

    final snackBar = SnackBar(
      content: snackBarContent,
      backgroundColor:
          backgroundColor ?? Theme.of(context).snackBarTheme.backgroundColor,
      action: action,
      duration: duration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showCustom(
    BuildContext context, {
    required Widget child,
    SnackBarAction? action,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      content: child,
      action: action,
      duration: duration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
