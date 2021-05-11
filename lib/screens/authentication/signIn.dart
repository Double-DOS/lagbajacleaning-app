import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/styles.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({this.toggleView});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign In to Book a Cleaning Session'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.00),
            child: Form(
              key: _formkey,
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
                    style: SemiBoldTitleTextStyle.copyWith(color: Colors.blue),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.toggleView('/sign-up');
                        },
                        child: Text(
                          "Don't have an account?",
                          style: SmallTextStyle.copyWith(
                              color: Colors.black54, fontSize: 14.0),
                        ),
                      ),
                      Text(
                        "Forgot Password",
                        style: SmallTextStyle.copyWith(
                            color: Colors.black54, fontSize: 14.0),
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
                      _auth.anonSignIn();
                    },
                    child:
                        Text('Sign In', style: TextStyle(color: Colors.blue)),
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
