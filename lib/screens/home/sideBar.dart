import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/shared.dart';

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
              leading: Icon(Icons.border_color),
              title: Text('Custom Request'),
              subtitle: Text('coming soon'),
              onTap: () => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(child: ComingSoonDialog);
                  },
                )
              },
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
