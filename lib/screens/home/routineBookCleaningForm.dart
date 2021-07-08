import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lagbaja_cleaning/models/pricing.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:paystack_manager/paystack_pay_manager.dart';
import 'package:provider/provider.dart';

class RoutineBookCleaningForm extends StatefulWidget {
  final userInfo;
  RoutineBookCleaningForm({this.userInfo});
  @override
  _RoutineBookCleaningFormState createState() =>
      _RoutineBookCleaningFormState();
}

class _RoutineBookCleaningFormState extends State<RoutineBookCleaningForm> {
  static final _routineBookCleaningFormKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  bool loading = false;
  bool successful = false;
  bool failed = false;
  bool _switchValue = false;
  String radioValue;
  String preferredCleaningDay;
  String selectedApartmentValue;
  String selectedLocation;
  DateTime selectedDate = DateTime.now();
  dynamic dateFormat = DateFormat.yMMMEd();
  DateTime orderDate = DateTime.now();
  String stringDate;
  double discount = 1.0;
  double apartmentCost = 0.0;
  double overallTotalCost = 0.0;
  double discountedCost = 0.0;
  double routineLength = 2.0;
  double sliderValue = 0;
  void displayDatePicker() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        stringDate = dateFormat.format(selectedDate);
      });
    }
  }

  Widget selectRoutineWidget(String radioValue) {
    return radioValue == 'Weekly'
        ? Wrap(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('So, for how many weeks shall we clean for you?',
                    style: BoldTitleTextStyle.copyWith(
                        fontSize: 15, color: Colors.blue)),
              ),
              Container(
                child: NumericStepButton(
                  minValue: 2,
                  maxValue: 20,
                  onChanged: (value) {
                    routineLength = value.toDouble();
                    setState(() {
                      overallTotalCost = discountedCost * routineLength;
                    });
                  },
                ),
              ),
              DropdownButtonFormField(
                  items: buildWeekdaysDropdown(),
                  icon: Icon(Icons.arrow_drop_down_circle_outlined,
                      color: Colors.blue),
                  validator: (val) =>
                      val == null ? 'Please select your cleaning day' : null,
                  onChanged: (value) {
                    setState(() {
                      preferredCleaningDay = value;
                    });
                  },
                  decoration:
                      inputDecoration('Select Preferred Cleaning Day...'))
            ],
          )
        : radioValue == 'Bi-Weekly'
            ? Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('So, how many times shall we clean for you?',
                        style: BoldTitleTextStyle.copyWith(
                            fontSize: 15, color: Colors.blue)),
                  ),
                  Container(
                    child: NumericStepButton(
                      minValue: 2,
                      maxValue: 20,
                      onChanged: (value) {
                        routineLength = double.parse(value.toString());
                      },
                    ),
                  ),
                  DropdownButtonFormField(
                      items: buildWeekdaysDropdown(),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.blue),
                      validator: (val) => val == null
                          ? 'Please select your cleaning day'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          preferredCleaningDay = value;
                        });
                      },
                      decoration:
                          inputDecoration('Select Preferred Cleaning Day...'))
                ],
              )
            : radioValue == 'Monthly'
                ? Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            'So, for how many months shall we clean for you?',
                            style: BoldTitleTextStyle.copyWith(
                                fontSize: 15, color: Colors.blue)),
                      ),
                      Container(
                        child: NumericStepButton(
                          minValue: 2,
                          maxValue: 20,
                          onChanged: (value) {
                            routineLength = double.parse(value.toString());
                          },
                        ),
                      ),
                      DropdownButtonFormField(
                          items: buildWeekdaysDropdown(),
                          icon: Icon(Icons.arrow_drop_down_circle_outlined,
                              color: Colors.blue),
                          validator: (val) => val == null
                              ? 'Please select your cleaning day'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              preferredCleaningDay = value;
                            });
                          },
                          decoration: inputDecoration(
                              'Select Preferred Cleaning Day...'))
                    ],
                  )
                : SizedBox(height: 10);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  List<Widget> buildApartmentDropdown() {
    return apartmentTypes.map((apartment) {
      return DropdownMenuItem(
        value: apartment,
        child: Text(
          apartment,
          style: SmallTextStyle.copyWith(color: Colors.blue),
        ),
      );
    }).toList();
  }

  List<Widget> buildWeekdaysDropdown() {
    return weekdays.map((weekday) {
      return DropdownMenuItem(
        value: weekday,
        child: Text(
          weekday,
          style: SmallTextStyle.copyWith(color: Colors.blue),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final secretKey = Provider.of<SecretKey>(context);
    void _onPaymentSuccessful(Transaction transaction) {
      print("Transaction was successful");
      print("Transaction Message ===> ${transaction.message}");
      print("Transaction Refrence ===> ${transaction.refrenceNumber}");

      CleaningSession initial = CleaningSession.initialData();
      dynamic result = DatabaseService(uid: user.uid).updateCleaningSession(
          location: selectedLocation,
          apartmentType: selectedApartmentValue,
          subscription: radioValue,
          userUid: user.uid,
          totalCost: overallTotalCost,
          isRated: initial.isRated,
          isPaid: true,
          routineLength: routineLength.toInt(),
          isCompleted: initial.isCompleted,
          cleaningDay: preferredCleaningDay,
          dateOrdered: initial.orderDate,
          cleaningDate: selectedDate);
      print("RESULT ----> ${result.toString()}");
      setState(() {
        successful = true;
        failed = false;
      });
    }

    void _onPaymentPending(Transaction transaction) {
      print("Transaction is pending");
      print("Transaction Refrence ===> ${transaction.refrenceNumber}");
    }

    void _onPaymentFailed(Transaction transaction) {
      setState(() {
        failed = true;
      });
      print("Transaction failed");
      print("Transaction Message ===> ${transaction.message}");
    }

    void _onPaymentCancelled(Transaction transaction) {
      print("Transaction was cancelled");
    }

    void processPayment(
        {BuildContext context,
        double amountPayable,
        String userEmail,
        String firstName,
        String lastName,
        String subscriptionType,
        String secretKey,
        String userUid}) {
      try {
        PaystackPayManager(context: context)
          // Don't store your secret key on users device.
          // Make sure this is retrive from your server at run time
          ..setSecretKey(secretKey)
          //accepts widget
          ..setCompanyAssetImage(Image(
            height: 50,
            image: AssetImage("assets/images/lagbaja.png"),
          ))
          ..setAmount(amountPayable.toInt() * 100)
          // ..setReference("your-unique-transaction-reference")
          ..setReference(
              "$userUid-$subscriptionType-${DateTime.now().microsecondsSinceEpoch.toString()}")
          ..setCurrency("NGN")
          ..setEmail(userEmail)
          ..setFirstName(firstName)
          ..setLastName(lastName)
          ..setMetadata(
            {
              "custom_fields": [
                {
                  "value": "snapTask",
                  "display_name": "Payment to",
                  "variable_name": "payment_to"
                }
              ]
            },
          )
          ..onSuccesful(_onPaymentSuccessful)
          ..onPending(_onPaymentPending)
          ..onFailed(_onPaymentFailed)
          ..onCancel(_onPaymentCancelled)
          ..initialize();
      } catch (error) {
        print("Payment Error ==> $error");
      }
    }

    print(user.uid);
    return successful
        ? Text('successful!!')
        : failed
            ? Text('failed!!')
            : loading
                ? Loading()
                : Form(
                    key: _routineBookCleaningFormKey,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text(
                            'NGN ${overallTotalCost.toString()}',
                            style: BoldTitleTextStyle.copyWith(
                                fontSize: 18, color: Colors.blue),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                enabled: !_switchValue,
                                controller: myController,
                                validator: (val) => val.isEmpty
                                    ? 'Please fill in location'
                                    : null,
                                decoration:
                                    inputDecoration('Enter Cleaning Location'),
                                onChanged: (val) {
                                  setState(() {
                                    selectedLocation = myController.text;
                                  });
                                  print(selectedLocation);
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch.adaptive(
                                    value: _switchValue,
                                    onChanged: (T) {
                                      setState(() {
                                        _switchValue = !_switchValue;
                                      });
                                      if (_switchValue) {
                                        myController.text =
                                            widget.userInfo.address;
                                        selectedLocation = myController.text;
                                      }
                                    },
                                    activeColor: Colors.blue[900],
                                  ),
                                  Text(
                                    'Use Home Address',
                                    style: SmallTextStyle.copyWith(
                                        color: Colors.blue),
                                  )
                                ],
                              ),
                              DropdownButtonFormField(
                                items: buildApartmentDropdown(),
                                validator: (val) => val == null
                                    ? 'Please select house type'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    selectedApartmentValue = value;
                                    switch (selectedApartmentValue) {
                                      case 'Single Room':
                                        apartmentCost =
                                            PricingList().singleRoom;
                                        break;
                                      case 'Self-Contain Room':
                                        apartmentCost =
                                            PricingList().singleSelfContainRoom;
                                        break;
                                      case 'Self-Contain Room and Parlour':
                                        apartmentCost = PricingList()
                                            .roomAndParlourSelfContain;
                                        break;
                                      case '2-Bedroom Apartment':
                                        apartmentCost =
                                            PricingList().twoBedroom;
                                        break;
                                      case '3-Bedroom Apartment':
                                        apartmentCost =
                                            PricingList().threeBedroom;
                                        break;
                                      case '4-Bedroom Apartment':
                                        apartmentCost =
                                            PricingList().fourBedroom;
                                        break;
                                      case 'Duplex':
                                        apartmentCost = PricingList().duplex;
                                        break;
                                    }
                                    apartmentCost += 2500;
                                    discountedCost = apartmentCost -
                                        (discount * apartmentCost);
                                    overallTotalCost =
                                        discountedCost * routineLength;
                                  });
                                },
                                icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    color: Colors.blue),
                                decoration:
                                    inputDecoration('Select House Type...'),
                              ),
                              Column(
                                children: [
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'Weekly',
                                    groupValue: radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        radioValue = value;
                                        discount =
                                            SubscriptionPlans().weeklyPlan;
                                        discountedCost = apartmentCost -
                                            (discount * apartmentCost);
                                        overallTotalCost =
                                            discountedCost * routineLength;
                                      });
                                    },
                                    title: Text(
                                      'Weekly',
                                      style: BodyTextStyle,
                                    ),
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'Bi-Weekly',
                                    groupValue: radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        radioValue = value;
                                        discount =
                                            SubscriptionPlans().biWeeklyPlan;
                                        discountedCost = apartmentCost -
                                            (discount * apartmentCost);
                                        overallTotalCost =
                                            discountedCost * routineLength;
                                      });
                                    },
                                    title: Text(
                                      'Bi-Weekly',
                                      style: BodyTextStyle,
                                    ),
                                  ),
                                  RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: 'Monthly',
                                    groupValue: radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        radioValue = value;
                                        discount =
                                            SubscriptionPlans().monthlylyPlan;
                                        discountedCost = apartmentCost -
                                            (discount * apartmentCost);
                                        overallTotalCost =
                                            discountedCost * routineLength;
                                      });
                                    },
                                    title: Text(
                                      'Monthly',
                                      style: BodyTextStyle,
                                    ),
                                  )
                                ],
                              ),
                              selectRoutineWidget(radioValue),
                              ElevatedButton(
                                child: Container(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Book Lagbaja!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                      Icon(Icons.add_location_alt_rounded,
                                          color: Colors.white),
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
                                ).copyWith(
                                  side: MaterialStateProperty.resolveWith<
                                      BorderSide>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 1,
                                        );
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
                                ),
                                onPressed: () async {
                                  if (_routineBookCleaningFormKey.currentState
                                      .validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    print(selectedDate);
                                    print(selectedApartmentValue);
                                    print(selectedLocation);
                                    print(overallTotalCost);
                                    CleaningSession initial =
                                        CleaningSession.initialData();
                                    processPayment(
                                        context: context,
                                        secretKey: secretKey.key,
                                        amountPayable: overallTotalCost,
                                        userEmail: user.email,
                                        firstName: widget.userInfo.firstName,
                                        lastName: widget.userInfo.lastName,
                                        subscriptionType: radioValue,
                                        userUid: user.uid);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
  }
}
