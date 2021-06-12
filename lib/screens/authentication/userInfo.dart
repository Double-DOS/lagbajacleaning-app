import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

class UserInfo extends StatefulWidget {
  final Map<String, dynamic> user;
  UserInfo({this.user});
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final AuthService _auth = AuthService();
  final _signUpFormkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String firstName = '';
  String lastName = '';
  String countryValue = "";
  String houseAddress = '';
  String stateOfResidence = '';
  String cityOfResidence = '';
  String error = '';
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ListView(
              children: [
                Container(
                    height: 100,
                    child:
                        Image(image: AssetImage('assets/images/lagbaja.png'))),
                Center(
                  child: Text(
                    'Join the clean community!',
                    style: SemiBoldTitleTextStyle.copyWith(
                        color: Colors.lightBlue),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.00),
                  child: Form(
                    key: _signUpFormkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          decoration: inputDecoration('First Name').copyWith(
                              prefixIcon: Icon(CupertinoIcons.person_alt)),
                          keyboardType: TextInputType.name,
                          style: SemiBoldTitleTextStyle.copyWith(
                              color: Colors.blue, fontSize: 16.0),
                          textCapitalization: TextCapitalization.words,
                          validator: (val) => val.isEmpty ? 'Required!' : null,
                          onChanged: (val) {
                            setState(() => firstName = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: inputDecoration('Last Name').copyWith(
                              prefixIcon: Icon(CupertinoIcons.person)),
                          keyboardType: TextInputType.name,
                          style: SemiBoldTitleTextStyle.copyWith(
                              color: Colors.blue, fontSize: 16.0),
                          validator: (val) => val.isEmpty ? 'Required!' : null,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (val) {
                            setState(() => lastName = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: inputDecoration('House Address').copyWith(
                              prefixIcon:
                                  Icon(CupertinoIcons.location_circle_fill)),
                          keyboardType: TextInputType.streetAddress,
                          style: SemiBoldTitleTextStyle.copyWith(
                              color: Colors.blue, fontSize: 16.0),
                          textCapitalization: TextCapitalization.words,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Required!';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() => houseAddress = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        // TextFormField(
                        //   decoration: inputDecoration('State of Residence')
                        //       .copyWith(
                        //           prefixIcon: Icon(CupertinoIcons.location)),
                        //   style: SemiBoldTitleTextStyle.copyWith(
                        //       color: Colors.blue, fontSize: 16.0),
                        //   validator: (val) => val.isEmpty ? 'Required!' : null,
                        //   onChanged: (val) {
                        //     setState(() => stateOfResidence = val);
                        //   },
                        // ),

                        SizedBox(height: 20.0),
                        CSCPicker(
                            showStates: true,
                            showCities: true,
                            onCountryChanged: (value) =>
                                setState(() => countryValue = value),
                            onStateChanged: (value) =>
                                setState(() => stateOfResidence = value),
                            onCityChanged: (value) =>
                                setState(() => cityOfResidence = value),
                            defaultCountry: DefaultCountry.Nigeria,
                            dropdownDecoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                            )),
                        OutlinedButton(
                          onPressed: () async {
                            if (_signUpFormkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              widget.user
                                  .putIfAbsent("firstName", () => firstName);
                              widget.user
                                  .putIfAbsent("lastName", () => lastName);
                              widget.user
                                  .putIfAbsent("address", () => houseAddress);
                              widget.user
                                  .putIfAbsent("state", () => stateOfResidence);
                              widget.user
                                  .putIfAbsent("city", () => cityOfResidence);
                              dynamic result =
                                  await _auth.emailSignUp(widget.user);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Sign Up failed! Check that your inputs are correct!';
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
                                          height: 250,
                                          padding: EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                error,
                                                textAlign: TextAlign.center,
                                                style: SmallTextStyle.copyWith(
                                                    fontSize: 20.0),
                                              ),
                                              Icon(
                                                CupertinoIcons.xmark_circle,
                                                size: 80.0,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }
                          },
                          child: Text('Sign Up',
                              style: TextStyle(color: Colors.blue)),
                          style: outlinedButtonStyle(context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
