import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class CleaningSessionTile extends StatelessWidget {
  final CleaningSession session;
  CleaningSessionTile({this.session});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(session.apartmentType),
        trailing: session.isCompleted
            ? CircleAvatar(
                backgroundColor: Colors.blue,
          child: Text('C', style: SemiBoldTitleTextStyle.copyWith(color: Colors.white),),
              )
            : CircleAvatar(
                backgroundColor: Colors.lightBlue[100],
          child: Text('P', style: SemiBoldTitleTextStyle.copyWith(color: Colors.white),),

        ),
        subtitle: Text(session.location),
        dense: true,
      ),
    );
  }
}
