import 'package:coincollect/constants/colors.dart';
import 'package:coincollect/forms/common_form.dart';
import 'package:coincollect/forms/listing_product.dart';
import 'package:coincollect/provider/category_provider.dart';
import 'package:coincollect/provider/product_provider.dart';
import 'package:coincollect/screens/auth/verify_email.dart';
import 'package:coincollect/screens/auth/login.dart';
import 'package:coincollect/screens/auth/phone_authentication.dart';
import 'package:coincollect/screens/auth/register.dart';
import 'package:coincollect/screens/category/product_category.dart';
import 'package:coincollect/screens/category/subcategory.dart';
import 'package:coincollect/screens/chat/user_chat.dart';
import 'package:coincollect/screens/homescreen.dart';
import 'package:coincollect/screens/geolocation_screen.dart';
import 'package:coincollect/screens/navigation_screen.dart';
import 'package:coincollect/screens/post/my_post_screen.dart';
import 'package:coincollect/screens/product/product_details_screen.dart';
import 'package:coincollect/screens/user_profile_screen.dart';
import 'package:coincollect/screens/boot_screen.dart';
import 'package:coincollect/screens/intro_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/reset_password.dart';
import 'screens/category/category_list.dart';
import 'screens/chat/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        )
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: blackColour,
          backgroundColor: whiteColour,
          fontFamily: 'Oswald',
          scaffoldBackgroundColor: whiteColour,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.screenId,
        routes: {
          SplashScreen.screenId: (context) => const SplashScreen(),
          LoginScreen.screenId: (context) => const LoginScreen(),
          PhoneAuthScreen.screenId: (context) => const PhoneAuthScreen(),
          LocationScreen.screenId: (context) => const LocationScreen(),
          HomeScreen.screenId: (context) => const HomeScreen(),
          WelcomeScreen.screenId: (context) => const WelcomeScreen(),
          RegisterScreen.screenId: (context) => const RegisterScreen(),
          EmailVerifyScreen.screenId: (context) => const EmailVerifyScreen(),
          ResetPasswordScreen.screenId: (context) =>
              const ResetPasswordScreen(),
          CategoryListScreen.screenId: (context) => const CategoryListScreen(),
          SubCategoryScreen.screenId: (context) => const SubCategoryScreen(),
          MainNavigationScreen.screenId: (context) =>
              const MainNavigationScreen(),
          ChatScreen.screenId: (context) => const ChatScreen(),
          MyPostScreen.screenId: (context) => const MyPostScreen(),
          ProfileScreen.screenId: (context) => const ProfileScreen(),
         
          UserFormReview.screenId: (context) => const UserFormReview(),
          CommonForm.screenId: (context) => const CommonForm(),
          ProductDetail.screenId: (context) => const ProductDetail(),
          ProductByCategory.screenId: (context) => const ProductByCategory(),
          UserChatScreen.screenId: (context) => const UserChatScreen(),
        });
  }
}
