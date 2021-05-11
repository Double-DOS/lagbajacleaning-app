import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/screens/authentication/signIn.dart';
import 'package:lagbaja_cleaning/screens/authentication/signup.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  String screenRoute = '/sign_in';
  void toggleAuthView(newRoute) {
    setState(() => screenRoute = newRoute);
  }

  @override
  Widget build(BuildContext context) {
    switch (screenRoute) {
      case '/sign-up':
        return SignUpPage(toggleView: toggleAuthView);
      default:
        return SignInPage(toggleView: toggleAuthView);
    }
  }
}
