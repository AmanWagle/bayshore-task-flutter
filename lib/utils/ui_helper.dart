import 'package:flutter/material.dart';

class UIHelper {
  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green.withOpacity(0.8),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Show Error SnackBar
  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red.withOpacity(0.8),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static const double textSizeMediumLarge = 15.0;

  static Widget verticalSpaceSmall(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double verticalSpaceSmall = queryData.size.height * 0.01;
    return SizedBox(height: verticalSpaceSmall);
  }

  static Widget verticalSpaceMedium(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double verticalSpaceMedium = queryData.size.height * 0.02;
    return SizedBox(height: verticalSpaceMedium);
  }

  static Widget horizontalSpaceSmall(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double horizontalSpaceSmall = queryData.size.width * 0.02;
    return SizedBox(width: horizontalSpaceSmall);
  }

  static Widget horizontal(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double horizontalSpaceSmall = queryData.size.width * 0.03;
    return SizedBox(width: horizontalSpaceSmall);
  }

  static Widget horizontalSpaceMedium(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double horizontalSpaceMedium = queryData.size.width * 0.04;
    return SizedBox(width: horizontalSpaceMedium);
  }
}
