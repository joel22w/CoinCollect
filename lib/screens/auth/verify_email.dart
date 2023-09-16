import 'package:coincollect/components/icon_button.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/constants/widgets.dart';
import 'package:coincollect/screens/geolocation_screen.dart';
import 'package:coincollect/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:open_mail_app/open_mail_app.dart';

class EmailVerifyScreen extends StatefulWidget {
  static const String screenId = 'email_otp_screen';

  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  bool isPinEntered = false;
  String smsCode = "";

  Auth authService = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _buildBody(context), // Call the _buildBody method
    );
  }

  Future<void> validateEmailOtp() async {
    if (kDebugMode) {
      print('your otp is : $smsCode');
    }
  }

  // Refactored the body of the widget into a separate method for clarity
  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Email',
                  style: TextStyle(
                    color: blackColour,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Check your email to verify your registered email',
                  style: TextStyle(
                    color: blackColour,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Lottie.asset(
                'assets/lottie/verify_lottie.json',
                width: double.infinity,
                height: 350,
              ),
            ),
            InkWell(
              onTap: () async {
                var result = await OpenMailApp.openMailApp();
                if (!result.didOpen && !result.canOpen) {
                  vibrantSnackBar(
                      context: context, content: 'email app not found');
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                  Navigator.pushReplacementNamed(
                      context, LocationScreen.screenId);
                }
              },
              child: CustomIconButton(
                  buttonText: 'Verify Email',
                  buttonColour: secondaryColour,
                  icon: Icons.verified_user,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            )
          ]),
        ),
      ],
    );
  }
}
