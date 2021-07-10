import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lagbaja_cleaning/models/pricing.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/home/oneOffBookCleaningForm.dart';
import 'package:lagbaja_cleaning/screens/home/cleaningSessionList.dart';
import 'package:lagbaja_cleaning/screens/home/lastContainer.dart';
import 'package:lagbaja_cleaning/screens/home/routineBookCleaningForm.dart';
import 'package:lagbaja_cleaning/screens/home/sessionOverviewSlider.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();
  static final carousel = SessionOverviewCarousel();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserProfileInfo>(context);
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    void _showCleaningForm() {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          context: context,
          builder: (BuildContext context) {
            return DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: StreamProvider.value(
                  value: DatabaseService().getPaystackSecretKey,
                  initialData: SecretKey('paystack'),
                  builder: (context, snapshot) {
                    return Container(
                      height: 0.56 * screenHeight,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.blue,
                            tabs: <Widget>[
                              Tab(
                                  text: 'One-off Booking',
                                  icon: Icon(Icons.airplane_ticket_outlined)),
                              Tab(
                                text: 'Routine Subscription',
                                icon: Icon(Icons.replay_outlined),
                              )
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                    color: Colors.white70,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: OneOffBookCleaningForm(
                                        userInfo: userInfo)),
                                Container(
                                    color: Colors.white70,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: RoutineBookCleaningForm(
                                        userInfo: userInfo)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          },
          isScrollControlled: true);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: SmallTextSize, end: LargeTextSize + 7),
                          duration: Duration(milliseconds: 300),
                          builder: (BuildContext context, double _fontSize,
                              Widget child) {
                            return Text(
                              'Hi, ${userInfo == null ? "" : userInfo.firstName}!',
                              style: BoldTitleTextStyle.copyWith(
                                  fontSize: _fontSize,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.normal),
                              textAlign: TextAlign.center,
                            );
                          }),
                      Text(
                        'Have you washed your hands?',
                        style: SmallTextStyle.copyWith(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.location),
                      Text(
                        userInfo == null
                            ? ""
                            : "${userInfo.city + ", " + userInfo.state}",
                        style: SmallTextStyle.copyWith(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  carousel,
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
            Center(
              child: Container(
                  height: 150,
                  child:
                      Image(image: AssetImage("assets/images/clean-man.png"))),
            ),
            LastContainer(),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Cleaning Sessions',
                textAlign: TextAlign.center,
                style: BodyTextStyle.copyWith(color: Colors.blue[900]),
              ),
            ),
            SafeArea(child: CleaningSessionsListView()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location_alt_outlined),
        onPressed: () {
          _showCleaningForm();
        },
      ),
    );
  }
}
