import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
                child: Text(
                  'C',
                  style: SemiBoldTitleTextStyle.copyWith(color: Colors.white),
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.lightBlue[100],
                child: Text(
                  'P',
                  style: SemiBoldTitleTextStyle.copyWith(color: Colors.white),
                ),
              ),
        subtitle: Text(session.location),
        dense: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                    ),
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  CupertinoIcons.xmark_circle,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  session.apartmentType,
                                  textAlign: TextAlign.center,
                                  style: BoldTitleTextStyle.copyWith(
                                    color: Colors.lightBlue[900],
                                  ),
                                ),
                                Text(
                                  session.location,
                                  textAlign: TextAlign.center,
                                  style: SmallTextStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              'Details:',
                              textAlign: TextAlign.start,
                              style: BoldTitleTextStyle.copyWith(
                                  color: Colors.lightBlue[900]),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Subscription',
                                      style: BodyTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          session.subscription,
                                          textAlign: TextAlign.center,
                                          style: BoldTitleTextStyle.copyWith(
                                            color: Colors.lightBlue[900],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Date Ordered',
                                      style: BodyTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          DateFormat.yMMMEd()
                                              .format(session.orderDate),
                                          textAlign: TextAlign.center,
                                          style: BoldTitleTextStyle.copyWith(
                                            color: Colors.lightBlue[900],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
