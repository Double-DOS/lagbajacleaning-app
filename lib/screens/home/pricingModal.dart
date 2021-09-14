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
  final isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affordable Prices, Just For You!'),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: [
            ExpansionPanelRadio(
              value: 'single_room',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Single Room',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '4000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '6000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '8500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '4550',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '5200',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '5850',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: 'single_room_self_con',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Self-Contain Room',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '5500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '7500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '10000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '5800',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '6400',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '7200',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: 'self_con_room_parlour',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Self-Contain Room And Parlour',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '7000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '9000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '11500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '6650',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '7600',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '8500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: '2_bedroom',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    '2-Bedroom Apartment',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '11500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '13500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '16000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '9800',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '11200',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '12600',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: '3_bedroom',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    '3-Bedroom Apartment',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '17500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '19500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '22000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '14000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '16000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '18000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: '4_bedroom',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    '4-Bedroom Apartment',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '21500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '23500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '26000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '16800',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '16200',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '21600',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ExpansionPanelRadio(
              value: 'duplex',
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Duplex',
                    style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue, fontSize: MediumTextSize),
                  ),
                );
              },
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Mild Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '33500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Standard Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '35500',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.airplane_ticket_outlined),
                    dense: true,
                    title: Text(
                      'Deep Cleaning',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '38000',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blue[900],
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '25200',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Bi-Weekly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '28800',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.replay_outlined),
                    dense: true,
                    title: Text(
                      'Monthly Routine',
                      style: BodyTextStyle,
                    ),
                    trailing: Text(
                      '32400',
                      style: BoldTitleTextStyle.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
