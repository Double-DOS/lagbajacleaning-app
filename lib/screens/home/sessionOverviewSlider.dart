import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/authentication/userInfo.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

Widget overviewContainer(
    String sessionCount, Color color, String caption, double width) {
  return Container(
      width: width,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: color,
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5,
                offset: Offset.fromDirection(1.0))
          ]),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Center(
            child: Text(
              caption,
              style: SemiBoldTitleTextStyle.copyWith(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              sessionCount,
              style: BoldTitleTextStyle.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ));
}

class SessionOverviewCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    final userInfo = Provider.of<UserProfileInfo>(context);
    return Container(
      child: FutureBuilder(
          future: DatabaseService(uid: userInfo.uid)
              .completedCleaningSessionOverView,
          builder:
              (BuildContext context, AsyncSnapshot<SessionOverview> snapshot) {
            return !snapshot.hasData
                ? SpinKitChasingDots(
                    color: Colors.blue,
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                        enableInfiniteScroll: true,
                        scrollPhysics: BouncingScrollPhysics(),
                        height: 70,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: [
                      overviewContainer(snapshot.data.pending, Colors.blue[200],
                          "Pending", screenWidth * 0.5),
                      overviewContainer(snapshot.data.completed,
                          Colors.blue[500], "Completed", screenWidth * 0.5),
                      overviewContainer(snapshot.data.total, Colors.blue[800],
                          "Total", screenWidth * 0.5),
                    ],
                  );
          }),
    );
  }
}
