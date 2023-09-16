import 'package:coincollect/components/font_heading.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/forms/login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String screenId = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColour,
      body: _buildBody(), // Call the _buildBody method
    );
  }

  // Refactored the body of the widget into a separate method
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LargeHeadingWidget(
              heading: 'Welcome', subHeading: 'Sign In Now'),
          LogInForm(),
        ],
      ),
    );
  }
}
