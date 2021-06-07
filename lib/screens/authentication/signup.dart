import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/screens/authentication/emailPassword.dart';
import 'package:lagbaja_cleaning/screens/authentication/userInfo.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

class SignUpPage extends StatelessWidget {
  final Function toggleView;
  SignUpPage({this.toggleView});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                final Map<String, dynamic> arguments = settings.arguments;
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(
                        builder: (context) =>
                            EmailAndPassword(toggleView: this.toggleView));
                    break;
                  case '/userInfo':
                    return MaterialPageRoute(
                        builder: (context) =>
                            UserInfo(user: arguments["user"]));
                    break;
                  default:
                    return MaterialPageRoute(
                        builder: (context) =>
                            EmailAndPassword(toggleView: this.toggleView));
                }
              },
            ),
          ),
        ));
  }
}
