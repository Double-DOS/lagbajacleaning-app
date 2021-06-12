import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/screens/home/cleaningSessionTile.dart';
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
      height: screenHeight * 0.125,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 5.0)]),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: cleaningSessionsList.take(5).toList().length,
          itemBuilder: (context, index) {
            return CleaningSessionTile(
                session: cleaningSessionsList.take(5).toList()[index]);
          },
          shrinkWrap: true),
    );
  }
}
