import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lagbaja_cleaning/models/pricing.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/shared.dart';
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
  bool _switchValue = false;
  String selectedApartmentValue;
  String selectedLocation;
  DateTime selectedDate = DateTime.now();
  dynamic dateFormat = DateFormat.yMMMEd();
  DateTime orderDate = DateTime.now();
  String stringDate;

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.uid);
    return Form(
      key: _routineBookCleaningFormKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            enabled: !_switchValue,
            controller: myController,
            validator: (val) => val.isEmpty ? 'Please fill in location' : null,
            decoration: inputDecoration('Enter Cleaning Location'),
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
                    myController.text = widget.userInfo.address;
                    selectedLocation = myController.text;
                  }
                },
                activeColor: Colors.blue[900],
              ),
              Text(
                'Use Home Address',
                style: SmallTextStyle.copyWith(color: Colors.blue),
              )
            ],
          ),
          DropdownButtonFormField(
            items: buildApartmentDropdown(),
            validator: (val) => val == null
                ? null
                : val.isEmpty
                    ? 'Please select house type'
                    : null,
            onChanged: (value) {
              setState(() {
                selectedApartmentValue = value;
              });
            },
            icon:
                Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.blue),
            decoration: inputDecoration('Select House Type...'),
          ),
          SizedBox(
            height: 10,
          ),
          // Text('When do you want us to come clean?',
          //     style: SmallTextStyle.copyWith(color: Colors.blue)),
          // SizedBox(
          //   height: 10,
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 'Today':
                    setState(() {
                      selectedDate = DateTime.now();
                      stringDate = dateFormat.format(selectedDate);
                    });
                    break;
                  case 'Tommorrow':
                    setState(() {
                      selectedDate = DateTime.now().add(Duration(days: 1));
                      stringDate = dateFormat.format(selectedDate);
                    });
                    break;
                  case 'Schedule':
                    displayDatePicker();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  padding: EdgeInsets.all(0),
                  value: 'Today',
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Today',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.all(0),
                  value: 'Tommorrow',
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title:
                        Text('Tomorrow', style: TextStyle(color: Colors.white)),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.all(0),
                  value: 'Schedule',
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Schedule Your Date',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
              icon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue),
                child: Icon(
                  Icons.date_range_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  stringDate != null
                      ? stringDate
                      : 'When do you want us to come clean?',
                  style: BoldTitleTextStyle.copyWith(
                      fontSize: 15, color: Colors.blue),
                ))
          ]),
          Center(
              child: OutlinedButton.icon(
                  onPressed: () async {
                    if (_routineBookCleaningFormKey.currentState.validate()) {
                      print(selectedDate);
                      print(selectedApartmentValue);
                      print(selectedLocation);
                    }
                  },
                  icon: Icon(Icons.add_location_alt_outlined),
                  label: Text('Book Lagbaja!')))
        ],
      ),
    );
  }
}
