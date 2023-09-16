import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/constants/widgets.dart';
import 'package:coincollect/screens/auth/login.dart';
import 'package:coincollect/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenId = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: welcomeBodyWidget(context),
    );
    
  }

  Widget welcomeBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coin Collect',
                  style: TextStyle(
                    color: blackColour,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Trading History, One Bill at a Time',
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Lottie.asset(
                'assets/lottie/welcome_lottie.json',
                width: double.infinity,
                height: 350,
              ),
            )
          ]),
        ),
        _bottomNavigationBar(context),
      ],
    );
  }

  Widget _bottomNavigationBar(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: elegantRoundedButton(
              context: context,
              buttonColour: whiteColour,
              borderColor: blackColour,
              textColor: blackColour,
              buttonText: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.screenId);
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: elegantRoundedButton(
              context: context,
              buttonColour: secondaryColour,
              buttonText: 'Sign Up',
              textColor: whiteColour,
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.screenId);
              }),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
