import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/styles.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({this.toggleView});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Join the Clean Community'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.00),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: SemiBoldTitleTextStyle.copyWith(color: Colors.blue),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    style: SemiBoldTitleTextStyle.copyWith(color: Colors.blue),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    style: SemiBoldTitleTextStyle.copyWith(color: Colors.blue),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => phoneNumber = val);
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.toggleView('/sign-in');
                        },
                        child: Text(
                          "Already have an account?",
                          style: SmallTextStyle.copyWith(
                              color: Colors.black54, fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      print(email);
                      print(password);
                      print(phoneNumber);
                      _auth.anonSignIn();
                    },
                    child:
                        Text('Sign Up', style: TextStyle(color: Colors.blue)),
                    style: outlinedButtonStyle(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
