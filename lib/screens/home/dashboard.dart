import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/styles.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<DocumentSnapshot>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Welcome, ${userInfo.data["firstName"]}!',
                          style: SemiBoldTitleTextStyle.copyWith(
                              fontWeight: FontWeight.w700),
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
                      userInfo.data["state"],
                      style: SmallTextStyle.copyWith(color: Colors.blue),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
