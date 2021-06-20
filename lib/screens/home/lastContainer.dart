import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lagbaja_cleaning/shared.dart';

class LastContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
            icon: Icon(Icons.money),
            onPressed: () {},
            label: Text('Pricing Plans', style: TextStyle(fontSize: 15)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.blue[100]; // Use the component's default.
                },
              ),
            ),
          ),
          TextButton.icon(
            icon: Icon(Icons.car_rental),
            onPressed: null,
            label: Text('Vehicle Cleaning', style: TextStyle(fontSize: 15)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.blue[100]; // Use the component's default.
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
