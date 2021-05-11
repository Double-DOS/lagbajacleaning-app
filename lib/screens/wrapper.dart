import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/authentication/authentication.dart';
import 'package:lagbaja_cleaning/screens/home/homePage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null ? HomePage() : AuthenticationPage();
  }
}
