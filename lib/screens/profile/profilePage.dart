import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/screens/authentication/emailPassword.dart';
import 'package:lagbaja_cleaning/screens/authentication/userInfo.dart';
import 'package:lagbaja_cleaning/screens/profile/profileEdit.dart';
import 'package:lagbaja_cleaning/screens/profile/profileView.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String screenRoute = '/';
  void toggleView(newRoute) {
    setState(() => screenRoute = newRoute);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _profileNavigatorKey =
        GlobalKey<NavigatorState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async =>
                !await _profileNavigatorKey.currentState.maybePop(),
            child: Navigator(
              key: _profileNavigatorKey,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(
                        builder: (context) => ProfileView(toggleView));
                    break;
                  case '/update':
                    return MaterialPageRoute(
                        builder: (context) => ProfileUpdate(toggleView));
                    break;
                  default:
                    return MaterialPageRoute(
                        builder: (context) => ProfileView(toggleView));
                }
              },
            ),
          ),
        ));
  }
}
