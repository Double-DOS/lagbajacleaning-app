import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class ProfileUpdate extends StatefulWidget {
  final toggleView;
  ProfileUpdate(this.toggleView);
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final AuthService _auth = AuthService();
  final _ProfileUpdateFormkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String firstName = '';
  String lastName = '';
  String countryValue = "";
  String email = '';
  String phoneNumber = '';
  String houseAddress = '';
  String stateOfResidence = '';
  String cityOfResidence = '';
  String error = '';
  DefaultCountry _defaultCountry = DefaultCountry.Nigeria;
  Widget _getCountryPicker() {
    // call expansion Panel
    return CSCPicker(
        showStates: true,
        showCities: true,
        onCountryChanged: (value) => setState(() => countryValue = value),
        onStateChanged: (value) => setState(() => stateOfResidence = value),
        onCityChanged: (value) => setState(() => cityOfResidence = value),
        defaultCountry: _defaultCountry,
        dropdownDecoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
        ));
  }

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);
    UserProfileInfo userProfileUpdate = Provider.of<UserProfileInfo>(context);
    return loading
        ? Loading()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                TweenAnimationBuilder(
                    tween: Tween<double>(
                        begin: SmallTextSize, end: LargeTextSize * 2),
                    duration: Duration(milliseconds: 300),
                    builder:
                        (BuildContext context, double _fontSize, Widget child) {
                      return Text('Profile',
                          textAlign: TextAlign.start,
                          style: BoldTitleTextStyle.copyWith(
                              fontSize: _fontSize, color: Colors.blue));
                    }),
                SizedBox(height: 20.0),
                Container(
                  child: Form(
                    key: _ProfileUpdateFormkey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 160,
                              child: TextFormField(
                                initialValue: userProfileUpdate.firstName,
                                decoration:
                                    inputDecoration('First Name').copyWith(
                                        prefixIcon: Icon(
                                  CupertinoIcons.person_fill,
                                )),
                                keyboardType: TextInputType.name,
                                style: SemiBoldTitleTextStyle.copyWith(
                                    color: Colors.blue, fontSize: 16.0),
                                textCapitalization: TextCapitalization.words,
                                validator: (val) =>
                                    val.isEmpty ? 'Required!' : null,
                                onChanged: (val) {
                                  setState(() => firstName = val);
                                },
                              ),
                            ),
                            Container(
                              width: 160,
                              child: TextFormField(
                                initialValue: userProfileUpdate.lastName,
                                decoration: inputDecoration('Last Name')
                                    .copyWith(
                                        prefixIcon:
                                            Icon(CupertinoIcons.person_fill)),
                                keyboardType: TextInputType.name,
                                style: SemiBoldTitleTextStyle.copyWith(
                                    color: Colors.blue, fontSize: 16.0),
                                validator: (val) =>
                                    val.isEmpty ? 'Required!' : null,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (val) {
                                  setState(() => lastName = val);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: inputDecoration('Phone NO.')
                              .copyWith(prefixIcon: Icon(CupertinoIcons.phone)),
                          keyboardType: TextInputType.phone,
                          style: SemiBoldTitleTextStyle.copyWith(
                              color: Colors.blue, fontSize: 16.0),
                          initialValue: userProfileUpdate.phoneNumber,
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
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: inputDecoration('House Address').copyWith(
                              prefixIcon:
                                  Icon(CupertinoIcons.location_circle_fill)),
                          keyboardType: TextInputType.streetAddress,
                          initialValue: userProfileUpdate.address,
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
                        SizedBox(height: 10.0),
                        _getCountryPicker(),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_ProfileUpdateFormkey.currentState.validate()) {
                              setState(() {
                                print('1111');
                                loading = true;
                              });
                              dynamic userInfo =
                                  await DatabaseService(uid: user.uid)
                                      .updateUserInfo(
                                          firstName: firstName,
                                          lastName: lastName,
                                          address: houseAddress,
                                          state: stateOfResidence,
                                          city: cityOfResidence,
                                          phoneNumber: phoneNumber);

                              if (userInfo == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Profile Update Failed! Please Try Again.';
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
                          child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Save!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Icon(
                                  Icons.person_add,
                                  size: 15,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.all(5),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        loading
                            ? SpinKitChasingDots(
                                color: Colors.blue,
                              )
                            : SizedBox(
                                width: 0,
                              ),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 15,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.all(5),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
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
