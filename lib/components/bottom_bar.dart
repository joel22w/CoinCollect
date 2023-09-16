import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';

import '../constants/colors.dart';

class BottomNavigationWidget extends StatelessWidget {
  final bool validator;
  final Function()? onPressed;
  final String buttonText;
  final ProgressDialog? progressDialog;
  const BottomNavigationWidget({
    Key? key,
    required this.validator,
    this.onPressed,
    required this.buttonText,
    this.progressDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: whiteColour,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: AbsorbPointer(
            absorbing: !validator,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: validator
                      ? MaterialStateProperty.all(secondaryColour)
                      : MaterialStateProperty.all(disabledColour)),
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: whiteColour,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
