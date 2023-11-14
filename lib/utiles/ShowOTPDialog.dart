import 'package:flutter/material.dart';

void showOTPDialog({                 //Alaa
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('Enter OTP'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: controller,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: onPressed, child: const Text('Done'))
            ],
          ));
}
