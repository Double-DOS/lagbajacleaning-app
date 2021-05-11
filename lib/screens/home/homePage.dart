import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/styles.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              label: Text('Logout', style: SmallTextStyle),
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                _auth.signOut();
              })
        ],
        title: Text('Your Dashboard'),
        leading: IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HI, Olumide.',
              style: BoldTitleTextStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location_alt_outlined),
        onPressed: null,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.blue)]),
          padding: EdgeInsets.only(left: 65),
          height: 50,
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 20.00, right: 20.00),
                iconSize: 35.00,
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.blue,
                ),
                onPressed: null,
              ),
              IconButton(
                padding: EdgeInsets.only(left: 20.00, right: 20.00),
                iconSize: 35.00,
                icon: Icon(
                  Icons.history_outlined,
                  color: Colors.blue,
                ),
                onPressed: null,
              ),
              IconButton(
                padding: EdgeInsets.only(left: 20.00, right: 20.00),
                iconSize: 35.00,
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.blue,
                ),
                onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
