import 'dart:async';
import 'package:coincollect/screens/navigation_screen.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/screens/intro_screen.dart';
import 'package:coincollect/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String screenId = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Auth authService = Auth();
  @override
  void initState() {
    permissionBasedNavigationFunc();
    super.initState();
  }

  permissionBasedNavigationFunc() {
    Timer(const Duration(seconds: 4), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.screenId);
        } else {
          Navigator.pushReplacementNamed(
              context, MainNavigationScreen.screenId);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Coin Collect',
                  style: TextStyle(
                      color: secondaryColour,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  'Share you hobby with others !',
                  style: TextStyle(
                    color: blackColour,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            height: MediaQuery.of(context).size.height,
            child: Lottie.asset(
              "assets/lottie/splash_lottie.json",
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
