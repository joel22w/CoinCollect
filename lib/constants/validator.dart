import 'package:intl/intl.dart';


// Validate mobile number input
String? validateMobile(value) {
  String? checkNullEmpty = checkNullEmptyValidation(value, "phone number");
  if (checkNullEmpty != null) {
    return checkNullEmpty;
  }
  if (value.length != 10) {
    return 'Please enter valid phone number';
  }
  return null;
}

// Validate email input
String? validateEmail(value, isValid) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (value.isNotEmpty && isValid == false) {
    return 'Invalid email, please enter a valid email';
  }
  return null;
}

// Validate password input
String? validatePassword(value, email) {
  if (email.isNotEmpty) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 3) {
      return 'Invalid password, please enter a valid password';
    }
  }
  return null;
}

// Validate password confirmation
String? validateSamePassword(value, password) {
  if (value != password) {
    return 'Confirm password must be the same as the password';
  } else if (value.isEmpty && password.isEmpty) {
    return null;
  } else if (value == null || value.isEmpty) {
    return 'Please enter the confirm password';
  }
  return null;
}

// Validate price input
String? validatePrice(value) {
  String? checkNullEmpty = checkNullEmptyValidation(value, 'price');
  if (checkNullEmpty != null) {
    return checkNullEmpty;
  }
  return null;
}


// Helper function to check for null or empty values with a custom title
String? checkNullEmptyValidation(value, title) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $title';
  }
  return null;
}

// Format an integer to a comma-separated string
String intToStringFormatter(value) {
  NumberFormat numberFormat = NumberFormat("##,##,##0");
  var parse = int.parse(value);
  var formattedValue = numberFormat.format(parse);
  return formattedValue;
}

// Format a Unix timestamp to readable date string
String formattedTime(value) {
  var date = DateTime.fromMicrosecondsSinceEpoch(value);
  var formattedDate = DateFormat.yMMMd().format(date);
  return formattedDate;
}
