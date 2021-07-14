import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/screens/home/cleaningSessionTile.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    final cleaningSessionsList = Provider.of<List<CleaningSession>>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TweenAnimationBuilder(
              tween:
                  Tween<double>(begin: SmallTextSize, end: LargeTextSize + 15),
              duration: Duration(milliseconds: 300),
              builder: (BuildContext context, double _fontSize, Widget child) {
                return Text('Cleaning History',
                    style: BoldTitleTextStyle.copyWith(
                        fontSize: _fontSize, color: Colors.blue));
              }),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 5),
            child: cleaningSessionsList.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'empty-trash',
                          child: Image(
                            image: AssetImage('assets/images/empty-trash.png'),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'No Cleaning Sessions yet!',
                          style: BoldTitleTextStyle.copyWith(
                              color: Colors.blue,
                              fontSize: 20,
                              fontStyle: FontStyle.normal),
                        ),
                      )
                    ],
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cleaningSessionsList.length,
                    itemBuilder: (context, index) {
                      return CleaningSessionTile(
                          session: cleaningSessionsList[index]);
                    },
                    shrinkWrap: true),
          ),
        ],
      ),
    );
  }
}
