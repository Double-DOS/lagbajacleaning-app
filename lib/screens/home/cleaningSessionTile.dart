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
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    session.apartmentType,
                                    textAlign: TextAlign.center,
                                    style: BoldTitleTextStyle.copyWith(
                                      color: Colors.white,
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
                          session.subscription == "One-Off"
                              ? oneOffDetails(session)
                              : routineDetails(session),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: session.isCompleted
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'CLEANED!',
                                              textAlign: TextAlign.center,
                                              style:
                                                  BoldTitleTextStyle.copyWith(
                                                color: Colors.lightBlue[900],
                                              ),
                                            ),
                                            Icon(
                                              CupertinoIcons.hand_thumbsup_fill,
                                              color: Colors.lightBlue[900],
                                            )
                                          ],
                                        )
                                      : session.routineProgress == 0
                                          ? Text(
                                              'PENDING',
                                              textAlign: TextAlign.center,
                                              style:
                                                  BoldTitleTextStyle.copyWith(
                                                color: Colors.red,
                                              ),
                                            )
                                          : Text(
                                              'IN PROGRESS',
                                              textAlign: TextAlign.center,
                                              style:
                                                  BoldTitleTextStyle.copyWith(
                                                color: Colors.lightBlue[300],
                                              ),
                                            )),
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

Widget oneOffDetails(CleaningSession session) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subscription',
                style: BodyTextStyle.copyWith(color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session.subscription,
                    textAlign: TextAlign.center,
                    style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.lightBlue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date Ordered',
                style: BodyTextStyle.copyWith(color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat.yMMMEd().format(session.orderDate),
                    textAlign: TextAlign.center,
                    style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.lightBlue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cleaning Date',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMEd().format(session.cleaningDate),
                        textAlign: TextAlign.center,
                        style: SemiBoldTitleTextStyle.copyWith(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                )
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Cost',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        session.totalCost.toString(),
                        textAlign: TextAlign.center,
                        style: SemiBoldTitleTextStyle.copyWith(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                )
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        session.isPaid ? 'Successful' : 'Pending',
                        textAlign: TextAlign.center,
                        style: SemiBoldTitleTextStyle.copyWith(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                )
              ],
            )),
      ],
    ),
  );
}

Widget routineDetails(CleaningSession session) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subscription',
                style: BodyTextStyle.copyWith(color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session.subscription,
                    textAlign: TextAlign.center,
                    style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.lightBlue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date Ordered',
                style: BodyTextStyle.copyWith(color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateFormat.yMMMEd().format(session.orderDate),
                    textAlign: TextAlign.center,
                    style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.lightBlue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cleaning Day',
                style: BodyTextStyle.copyWith(color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session.cleaningDay,
                    textAlign: TextAlign.center,
                    style: SemiBoldTitleTextStyle.copyWith(
                      color: Colors.lightBlue[900],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Routine Length',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.replay_rounded,
                            color: Colors.lightBlue[900]),
                        Text(
                          '${session.routineProgress} of ${session.routineLength} Sessions',
                          style: SemiBoldTitleTextStyle.copyWith(
                            color: Colors.lightBlue[900],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        //progress
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
          child: LinearProgressIndicator(
            color: Colors.lightBlue[900],
            backgroundColor: Colors.white,
            minHeight: 10,
            value: (session.routineProgress.toDouble()) / session.routineLength,
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Cost',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        session.totalCost.toString(),
                        textAlign: TextAlign.center,
                        style: SemiBoldTitleTextStyle.copyWith(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                )
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
                  style: BodyTextStyle.copyWith(color: Colors.white),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        session.isPaid ? 'Successful' : 'Pending',
                        textAlign: TextAlign.center,
                        style: SemiBoldTitleTextStyle.copyWith(
                          color: Colors.lightBlue[900],
                        ),
                      )),
                )
              ],
            )),
      ],
    ),
  );
}
