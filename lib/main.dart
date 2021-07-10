import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/wrapper.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        theme: ThemeData(
            backgroundColor: Colors.red,
            textTheme: TextTheme(
                headline1: BoldTitleTextStyle,
                headline2: BoldItalicTitleTextStyle,
                bodyText1: BodyTextStyle,
                bodyText2: BodyTextStyle),
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(headline1: AppBarTextStyle),
                backgroundColor: Colors.blue,
                elevation: 10.00,
                shadowColor: Colors.purple)),
      ),
    );
  }
}
