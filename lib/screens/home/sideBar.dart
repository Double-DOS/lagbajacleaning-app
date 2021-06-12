import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';

class SideDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            semanticContainer: true,
            color: Colors.blue,
            elevation: 0,
            borderOnForeground: false,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => {},
            ),
          ),
          Card(
            semanticContainer: true,
            color: Colors.blue,
            elevation: 0,
            borderOnForeground: false,
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () => {},
            ),
          ),
          Card(
            semanticContainer: true,
            color: Colors.blue,
            elevation: 0,
            borderOnForeground: false,
            child: ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {},
            ),
          ),
          Card(
            semanticContainer: true,
            color: Colors.blue,
            elevation: 0,
            borderOnForeground: false,
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {_auth.signOut()},
            ),
          ),
        ],
      ),
    );
  }
}
