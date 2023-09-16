import 'package:coincollect/components/font_heading.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/forms/register.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const screenId = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColour,
      body: _buildBody(), // Call the _buildBody method
    );
  }

  // Refactored the body of the widget into a separate method for clarity
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: LargeHeadingWidget(
              heading: 'Create Account',
              subHeading: 'Enter your details to sign up in CoinCollect.',
              anotherTaglineText: '\nAlready have an account ?',
              anotherTaglineColor: secondaryColour,
              subheadingTextSize: 16,
              taglineNavigation: true,
            ),
          ),
          const RegisterForm(), // Include the RegisterForm widget
        ],
      ),
    );
  }
}
