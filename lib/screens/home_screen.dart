import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/screens/chat_list_screen.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'call screens/pickup screens/pickup_layout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;
  double _labelFontSize = 10;
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    //SchedulerBinding is used because initState is called even before the first screen is drawn. Hence, no context is available at first, this throws an error. Adding a postFrmeCallback calls the below function after the home screen has been architected.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false); //gets user details from db when home screen is loaded
      userProvider.refreshUser();
    });

    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    //wrapping the scaffold with a pickup layout replaces the home screen with the pickup screen seamlessly when a call is being received. Else, it displays the home screen.
    return PickupLayout(
          scaffold: Scaffold(
        backgroundColor: kblackColor,
        body: PageView(
          children: <Widget>[
           Container(
             child: ChatListScreen(),
           ),
            Center(
              child: Text('Call Logs'),
            ),
            Center(
              child: Text('Contact Screen'),
            )
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CupertinoTabBar(
              backgroundColor: kblackColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                    color: (_page == 0) ? klightBlueColor : kgreyColor,
                  ),
                  title: Text(
                    'Chats',
                    style: TextStyle(
                      fontSize:_labelFontSize,
                      color: (_page == 0) ? klightBlueColor : kgreyColor,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.call,
                    color: (_page == 1) ? klightBlueColor : kgreyColor,
                  ),
                  title: Text(
                    'Call Log',
                    style: TextStyle(
                      fontSize:_labelFontSize,
                      color: (_page == 1) ? klightBlueColor : kgreyColor,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.contact_phone,
                    color: (_page == 2) ? klightBlueColor : kgreyColor,
                  ),
                  title: Text(
                    'Contact',
                    style: TextStyle(
                      fontSize:_labelFontSize,
                      color: (_page == 2) ? klightBlueColor : kgreyColor,
                    ),
                  ),
                ),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}
