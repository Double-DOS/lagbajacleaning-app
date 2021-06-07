import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/shared.dart';

class BookCleaningForm extends StatefulWidget {
  final key;
  BookCleaningForm({this.key});
  @override
  _BookCleaningFormState createState() => _BookCleaningFormState();
}

class _BookCleaningFormState extends State<BookCleaningForm> {
  static final _bookCleaningFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _bookCleaningFormKey,
      child: Column(
        children: [
          TextFormField(
            key: widget.key,
            keyboardType: TextInputType.text,
            decoration: inputDecoration('Enter Cleaning Location'),
            onChanged: (val){
              print(val);
            },
          )
        ],
      ),

    );
  }
}
