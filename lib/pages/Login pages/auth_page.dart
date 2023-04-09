import 'package:flutter/material.dart';

import 'login_page.dart';
import 'signup_page.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        showSignUpPage: toggleScreens,
      );
    } else {
      return SignUp(
        showLoginPage: toggleScreens,
      );
    }
  }
}
