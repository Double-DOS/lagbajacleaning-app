import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
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
                      height: 0.6 * screenHeight,
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
        child: Container(
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
                        Row(
                          children: [
                            Text(
                              'Hi, ${userInfo == null ? "" : userInfo.firstName}!',
                              style: BoldTitleTextStyle.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 34),
                            ),
                            Icon(
                              CupertinoIcons.sun_max_fill,
                              color: Colors.yellow,
                            )
                          ],
                        ),
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
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Recent Cleaning Sessions',
                        textAlign: TextAlign.end,
                        style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                      ),
                    ),
                    SafeArea(child: CleaningSessionsListView()),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'See Details',
                        textAlign: TextAlign.end,
                        style: BodyTextStyle.copyWith(color: Colors.blue[900]),
                      ),
                    ),
                  ],
                ),
              ),
              LastContainer(),
              Center(
                child: Container(
                    height: 170,
                    child: Image(
                        image: AssetImage("assets/images/clean-man.png"))),
              ),
            ],
          ),
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
