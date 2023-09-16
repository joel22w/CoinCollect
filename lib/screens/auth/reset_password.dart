import 'package:coincollect/components/font_heading.dart';
import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/forms/reset.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String screenId = 'reset_password_screen';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
        children: [
          LargeHeadingWidget(
            heading: 'Forgot Password',
            subHeading: 'Enter your email to reset your',
            headingTextSize: 35,
            subheadingTextSize: 20,
          ),
          ResetForm(), // Include the ResetForm widget
        ],
      ),
    );
  }
}
