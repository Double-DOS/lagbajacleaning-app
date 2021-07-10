import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/history/historyPage.dart';
import 'package:lagbaja_cleaning/screens/home/dashboard.dart';
import 'package:lagbaja_cleaning/screens/home/lastContainer.dart';
import 'package:lagbaja_cleaning/screens/home/sideBar.dart';
import 'package:lagbaja_cleaning/screens/profile/profileEdit.dart';
import 'package:lagbaja_cleaning/screens/profile/profilePage.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isMenuClicked = false;
  int _index = 0;
  Duration duration = Duration(milliseconds: 500);
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  final List<Widget> _tabs = [Dashboard(), HistoryPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(_animationController);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(isMenuClicked);
    Size screenSize = MediaQuery.of(context).size;
    final user = Provider.of<MyUser>(context);
    return Stack(
      children: [
        SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
                scale: _menuScaleAnimation, child: SideDrawer())),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: isMenuClicked ? 0.4 * screenSize.width : 0,
          right: isMenuClicked ? -0.4 * screenSize.width : 0,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              elevation: 10,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.white10,
                  elevation: 0.0,
                  leading: IconButton(
                      icon: Icon(isMenuClicked
                          ? Icons.close_rounded
                          : Icons.menu_rounded),
                      onPressed: () {
                        setState(() {
                          isMenuClicked = !isMenuClicked;
                          print(isMenuClicked);
                        });
                        if (isMenuClicked) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                      },
                      color: Colors.blue),
                ),
                body: MultiProvider(
                    providers: [
                      StreamProvider.value(
                          initialData: UserProfileInfo.initialData(),
                          value: DatabaseService(uid: user.uid).getUserInfo),
                      StreamProvider.value(
                          value: DatabaseService(uid: user.uid)
                              .allUserCleaningSession,
                          initialData: <CleaningSession>[
                          ])
                    ],
                    builder: (context, child) {
                      return _tabs[_index];
                    }),
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.white,
                  color: Colors.blue,
                  buttonBackgroundColor: Colors.blue,
                  height: 50,
                  index: _index,
                  onTap: (index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  items: [
                    Icon(
                      Icons.dashboard_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                    Icon(
                      CupertinoIcons.news_solid,
                      color: Colors.white,
                      size: 25,
                    ),
                    Icon(
                      CupertinoIcons.person_circle_fill,
                      color: Colors.white,
                      size: 25,
                    ),



                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
