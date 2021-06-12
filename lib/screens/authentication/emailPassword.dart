import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

class EmailAndPassword extends StatefulWidget {
  final Function toggleView;
  EmailAndPassword({this.toggleView});
  @override
  _EmailAndPasswordState createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  final AuthService _auth = AuthService();
  final _signUpFormkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String confirmPassword = '';
  String phoneNumber = '';
  String error = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ListView(
        children: [
          Container(
              height: 100,
              child: Image(image: AssetImage('assets/images/lagbaja.png'))),
          Center(
            child: Text(
              'Join the clean community!',
              style: SemiBoldTitleTextStyle.copyWith(color: Colors.lightBlue),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.00),
            child: Form(
              key: _signUpFormkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: inputDecoration('Email')
                        .copyWith(prefixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    style: SemiBoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: 16.0),
                    validator: (val) => val.isEmpty && !val.contains('@')
                        ? 'Enter an email!'
                        : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: inputDecoration('Phone NO.')
                        .copyWith(prefixIcon: Icon(CupertinoIcons.phone)),
                    keyboardType: TextInputType.phone,
                    style: SemiBoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: 16.0),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please Enter a Phone Number!';
                      } else if (val.length < 11) {
                        return 'Please enter a valid phone number';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() => phoneNumber = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: inputDecoration('Password').copyWith(
                        prefixIcon: Icon(CupertinoIcons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye_fill),
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword))),
                    style: SemiBoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: 16.0),
                    obscureText: hidePassword,
                    validator: (val) => val.length < 6
                        ? 'Password must be more than 6 chars long!'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: inputDecoration('Confirm Password').copyWith(
                        prefixIcon: Icon(CupertinoIcons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye_fill),
                            onPressed: () =>
                                setState(() => hidePassword = !hidePassword))),
                    style: SemiBoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: 16.0),
                    obscureText: hidePassword,
                    validator: (val) =>
                        val != password ? "Passwords Don't match" : null,
                    onChanged: (val) {
                      setState(() => confirmPassword = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.toggleView('/sign-in');
                        },
                        child: Text(
                          "Already have an account?",
                          style: SmallTextStyle.copyWith(
                              color: Colors.black54, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  OutlinedButton(
                      onPressed: () async {
                        if (_signUpFormkey.currentState.validate()) {
                          Map<String, dynamic> user = {
                            'email': email,
                            'password': password,
                            'phoneNumber': phoneNumber
                          };
                          Navigator.pushNamed(context, '/userInfo',
                              arguments: {"user": user});
                        }
                      },
                      child: Text('Next', style: TextStyle(color: Colors.blue)),
                      style: outlinedButtonStyle(context))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
