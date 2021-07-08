import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/screens/home/cleaningSessionTile.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class CleaningSessionsListView extends StatefulWidget {
  @override
  _CleaningSessionsListViewState createState() =>
      _CleaningSessionsListViewState();
}

class _CleaningSessionsListViewState extends State<CleaningSessionsListView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final cleaningSessionsList = Provider.of<List<CleaningSession>>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: cleaningSessionsList.length == 0
          ? Column(
              children: [
                Text(
                  'No Cleaning Sessions yet!',
                  style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.blue,
                      fontSize: 20,
                      fontStyle: FontStyle.normal),
                ),
                Container(
                  height: 200,
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 'empty-trash',
                    child: Image(
                      image: AssetImage('assets/images/empty-trash.png'),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: cleaningSessionsList
                  .take(5)
                  .map((session) => CleaningSessionTile(session: session))
                  .toList(),
            ),
    );
  }
}
