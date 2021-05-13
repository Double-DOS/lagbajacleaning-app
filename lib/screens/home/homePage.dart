import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/home/dashboard.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider.value(
      initialData: null,
      value: DatabaseService(uid: user.uid).userInfo,
      child: Scaffold(
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
        body: Dashboard(),
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
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 35.00,
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: null,
                ),
                IconButton(
                  iconSize: 35.00,
                  icon: Icon(
                    Icons.history_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: null,
                ),
                IconButton(
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
      ),
    );
  }
}
