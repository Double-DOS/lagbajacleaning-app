import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';
import 'package:lagbaja_cleaning/screens/home/dashboard.dart';
import 'package:lagbaja_cleaning/screens/home/sideBar.dart';
import 'package:lagbaja_cleaning/services/auth.dart';
import 'package:lagbaja_cleaning/services/database.dart';
import 'package:lagbaja_cleaning/shared.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final AuthService _auth = AuthService();
  bool isMenuClicked = false;
  int _index = 0;
  Duration duration = Duration(milliseconds: 500);
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  final List<Widget> _tabs = [
    Dashboard(),
    Dashboard(),
    Dashboard()
  ];

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_animationController);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0,0)).animate(_animationController);
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
    final user = Provider.of<User>(context);
    return Stack(
      children: [
        SlideTransition(
          position: _slideAnimation,
            child: ScaleTransition(
              scale:_menuScaleAnimation,
                child: SideDrawer()
            )
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 700),
          top: 0,
          bottom: 0,
          left: isMenuClicked?0.4*screenSize.width:0,
          right: isMenuClicked?-0.4*screenSize.width:0,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              elevation: 10,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: Colors.white38,
                  elevation: 0.0,
                  leading: IconButton(
                    icon:  Icon(isMenuClicked? Icons.close_rounded: Icons.menu_rounded),
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {
                        isMenuClicked = !isMenuClicked;
                        print(isMenuClicked);
                      });
                      if(isMenuClicked){
                        _animationController.forward();
                      }else{
                        _animationController.reverse();
                      }

                    },
                  ),
                ),
                body: MultiProvider(
                    providers: [
                      StreamProvider.value(
                          initialData: UserProfileInfo.initialData(),
                          value: DatabaseService(uid: user.uid).getUserInfo),
                      StreamProvider.value(
                          value: DatabaseService(uid: user.uid).allUserCleaningSession,
                          initialData: [
                            CleaningSession.initialData(),
                          ])
                    ],
                    builder: (context, child) {
                      return _tabs[_index];
                    }),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _index,
                  onTap: (index){
                    setState(() {
                      _index = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: 'Dashboard',
                      icon: Icon(
                        Icons.dashboard_outlined,
                        color: Colors.blue,
                      ),
                      activeIcon: Icon(
                        Icons.dashboard_rounded,
                        color: Colors.blue,
                      )

                    ),
                    BottomNavigationBarItem(
                      label: 'History',
                        icon: Icon(
                          Icons.location_history_outlined,
                          color: Colors.blue,
                        ),
                        activeIcon: Icon(
                          Icons.location_history_rounded,
                          color: Colors.blue,
                        )
                    ),
                    BottomNavigationBarItem(
                      label: 'Settings',
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.blue,
                        ),
                        activeIcon: Icon(
                          Icons.settings_rounded,
                          color: Colors.blue,
                        )
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
