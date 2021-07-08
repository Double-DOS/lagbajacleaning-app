import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  final toggleView;
  ProfileView(this.toggleView);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    UserProfileInfo userInfo = Provider.of<UserProfileInfo>(context);
    User user = Provider.of<User>(context);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            TweenAnimationBuilder(
              tween:
                  Tween<double>(begin: SmallTextSize, end: LargeTextSize * 2),
              duration: Duration(milliseconds: 300),
              builder: (BuildContext context, double _fontSize, Widget child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Profile',
                      textAlign: TextAlign.start,
                      style: BoldTitleTextStyle.copyWith(
                          fontSize: _fontSize, color: Colors.blue)),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              tileColor: null,
              contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              leading: Icon(
                CupertinoIcons.person_alt,
                color: Colors.blue,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '${userInfo.firstName} ${userInfo.lastName}',
                  style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                ),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              height: 0,
            ),
            ListTile(
              tileColor: null,
              contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              leading: Icon(
                Icons.phone_iphone_rounded,
                color: Colors.blue,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '${userInfo.phoneNumber}',
                  style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                ),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              height: 0,
            ),
            ListTile(
              tileColor: null,
              contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              leading: Icon(
                Icons.email,
                color: Colors.blue,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '${user.email}',
                  style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                ),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              height: 0,
            ),
            ListTile(
              tileColor: null,
              contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              leading: Icon(
                CupertinoIcons.location_circle_fill,
                color: Colors.blue,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '${userInfo.address}',
                  style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                ),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              height: 0,
            ),
            ListTile(
              tileColor: null,
              contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              leading: Icon(
                CupertinoIcons.map_fill,
                color: Colors.blue,
                size: 30,
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  '${userInfo.city}, ${userInfo.state}.',
                  style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                ),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              height: 0,
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/update'),
                child: Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Edit',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Icon(CupertinoIcons.pencil_circle, color: Colors.white)
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.all(5),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
