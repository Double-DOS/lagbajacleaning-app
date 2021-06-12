import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/pricing.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class BookCleaningForm extends StatefulWidget {
  final userInfo;
  BookCleaningForm({this.userInfo});
  @override
  _BookCleaningFormState createState() => _BookCleaningFormState();
}

class _BookCleaningFormState extends State<BookCleaningForm> {
  DateTime _selectedDate = DateTime.now();

  static final _bookCleaningFormKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  bool _switchValue = false;
  String selectedApartmentValue = apartmentTypes.first;
  String selectedLocation;
  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
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
    return Form(
      key: _bookCleaningFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            enabled: !_switchValue,
            controller: myController,
            decoration: inputDecoration('Enter Cleaning Location'),
            onChanged: (val) {},
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
                  if (_switchValue) myController.text = widget.userInfo.address;
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
          Text('When do you want us to come clean?',
              style: SmallTextStyle.copyWith(color: Colors.blue)),
          SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            children:[
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDate = DateTime.now();
                            });
                          },
                          child: ListTile(
                            title: Text('Today'),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedDate =
                                  DateTime.now().add(Duration(days: 1));
                            });
                          },
                          child: ListTile(
                            title: Text('Tomorrow'),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: InkWell(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)));
                            if (picked != null) {
                              setState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                          child: ListTile(
                            title: Text('Schedule Your Date'),
                          ),
                        ),
                      )
                    ],
                icon: Icon(Icons.date_range_rounded, size: 30.0)),

              Padding(
                padding: EdgeInsets.all(15),
                  child: Text(_selectedDate.toString()))
    ]
          ),
          Center(child: OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.add_location_alt_outlined), label: Text('Book Lagbaja!')))
        ],
      ),
    );
  }
}
