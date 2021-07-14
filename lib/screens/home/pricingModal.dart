import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/shared.dart';

class PricingModal extends StatefulWidget {
  const PricingModal({Key key}) : super(key: key);

  @override
  _PricingModalState createState() => _PricingModalState();
}

class _PricingModalState extends State<PricingModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        child: DefaultTabController(
          length: 4,
          child: Container(
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: 'Mild',
                        icon: Icon(CupertinoIcons.smoke_fill),
                      ),
                      Tab(
                        text: 'Standard',
                        icon: Icon(CupertinoIcons.smoke_fill),
                      ),
                      Tab(
                        text: 'Deep',
                        icon: Icon(CupertinoIcons.smoke_fill),
                      ),
                      Tab(
                        text: 'Routine',
                        icon: Icon(CupertinoIcons.smoke_fill),
                      ),
                    ],
                    labelColor: Colors.blue,
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    MildPlan(),
                    StandardPlan(),
                    DeepPlan(),
                    DeepPlan(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MildPlan extends StatefulWidget {
  const MildPlan({Key key}) : super(key: key);

  @override
  _MildPlanState createState() => _MildPlanState();
}

class _MildPlanState extends State<MildPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Text('Mild Cleaning',
          style: BoldTitleTextStyle.copyWith(
            color: Colors.blue,
          )),
    ]));
  }
}

class StandardPlan extends StatefulWidget {
  const StandardPlan({Key key}) : super(key: key);

  @override
  _StandardPlanState createState() => _StandardPlanState();
}

class _StandardPlanState extends State<StandardPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Standard Cleaning',
            style: BoldTitleTextStyle.copyWith(color: Colors.blue),
          )
        ],
      ),
    );
  }
}

class DeepPlan extends StatefulWidget {
  const DeepPlan({Key key}) : super(key: key);

  @override
  _DeepPlanState createState() => _DeepPlanState();
}

class _DeepPlanState extends State<DeepPlan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Deep Cleaning',
            style: BoldTitleTextStyle.copyWith(color: Colors.blue),
          )
        ],
      ),
    );
  }
}
