import 'package:coincollect/components/icon_button.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/screens/auth/phone_authentication.dart';
import 'package:coincollect/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpButtons extends StatefulWidget {
  const SignUpButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpButtons> createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  Auth authService = Auth();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const PhoneAuthScreen(
                          isFromLogin: false,
                        )));
          },
          child: CustomIconButton(
            buttonText: 'Signup with Phone',
            imageIcon: 'assets/phone.png',
            buttonColour: greyColour,
            imageColour: whiteColour,
            imageRadius: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () async {
            User? user = await Auth.signInWithGoogle(context: context);
            if (user != null) {
              authService.getAdminCredentialPhoneNumber(context, user);
            }
          },
          child: CustomIconButton(
            buttonText: 'Signup with Google',
            imageIcon: 'assets/google.png',
            buttonColour: whiteColour,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
