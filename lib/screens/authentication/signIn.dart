import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({this.toggleView});
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _signInFormKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.only(top: 70, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                      height: 100,
                      child: Image(
                          image: AssetImage('assets/images/lagbaja.png'))),
                  Text(
                    'Sign in to your dashboard!',
                    style: SemiBoldTitleTextStyle.copyWith(color: Colors.blue),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.00),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: inputDecoration('Email')
                                .copyWith(prefixIcon: Icon(Icons.email)),
                            keyboardType: TextInputType.emailAddress,
                            style: SemiBoldTitleTextStyle.copyWith(
                                color: Colors.blue, fontSize: 16.0),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email!' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: inputDecoration('Password').copyWith(
                                prefixIcon: Icon(CupertinoIcons.lock),
                                suffixIcon: IconButton(
                                    icon: Icon(hidePassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye_fill),
                                    onPressed: () => setState(
                                        () => hidePassword = !hidePassword))),
                            style: SemiBoldTitleTextStyle.copyWith(
                                color: Colors.blue, fontSize: 16.0),
                            validator: (val) => val.length < 6
                                ? 'Password must be more than 6 chars long!'
                                : null,
                            obscureText: hidePassword,
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
                              TextButton(
                                onPressed: () {
                                  widget.toggleView('/sign-up');
                                },
                                child: Text(
                                  "Don't have an account?",
                                  style: SmallTextStyle.copyWith(
                                      color: Colors.black54, fontSize: 14.0),
                                ),
                              ),
                              TextButton(onPressed: ()async{
                                await _auth.resetPassword(email);
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text('Password Reset Steps has been sent to your email!'), backgroundColor: Colors.blue)
                               );
                              }, child: Text(
                                "Forgot Password?",
                                style: SmallTextStyle.copyWith(
                                    color: Colors.black54, fontSize: 14.0),
                              ),)

                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              if (_signInFormKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.emailSignIn(email, password);
                                if (result != "pass") {
                                  setState(() {
                                    loading = false;
                                    error = result;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: Colors.lightBlue,
                                          child: Container(
                                            width: double.infinity,
                                            height: 200,
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  error,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      SmallTextStyle.copyWith(
                                                          fontSize: 20.0),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Icon(
                                                    CupertinoIcons.xmark_circle,
                                                    size: 80.0,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                            child: Container(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Sign In',
                                      style: TextStyle(color: Colors.blue)),
                                  Icon(Icons.login, color: Colors.blue)
                                ],
                              ),
                            ),
                            style: outlinedButtonStyle(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
