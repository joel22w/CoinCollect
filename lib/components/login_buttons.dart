import 'package:coincollect/components/icon_button.dart';
import 'package:coincollect/constants/Colors.dart';
import 'package:coincollect/screens/auth/phone_authentication.dart';
import 'package:coincollect/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginInButtons extends StatefulWidget {
  const LoginInButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginInButtons> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginInButtons> {
  Auth authService = Auth();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const PhoneAuthScreen()));
          },
          child: CustomIconButton(
            buttonText: 'Sign In with Phone',
            imageIcon: 'assets/phone.png',
            buttonColour: greyColour,
            imageColour: whiteColour,
            imageRadius: 20,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () async {
            User? user = await Auth.signInWithGoogle(context: context);
            if (user != null) {
              authService.getAdminCredentialPhoneNumber(context, user);
            }
          },
          child: CustomIconButton(
            buttonText: 'Sign In with Google',
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
