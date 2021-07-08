import 'package:an_agile_squad/backend/firebase%20methods/auth_methods.dart';
import 'package:an_agile_squad/backend/local%20db/repository/log_repository.dart';
import 'package:an_agile_squad/enum/user_state.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/screens/chat_list_screen.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/screens/log%20screen/log_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'call screens/pickup screens/pickup_layout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//WidgetsBindingObserver is used to keep track of the app lifecycle. This is reflected by the online presense indicator
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  PageController pageController;
  int _page = 0;
  double _labelFontSize = 10;
  UserProvider userProvider;
  AuthMethods authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
    //SchedulerBinding is used because initState is called even before the first screen is drawn. Hence, no context is available at first, this throws an error. Adding a postFrmeCallback calls the below function after the home screen has been architected.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context,
          listen: false); //gets user details from db when home screen is loaded
      await userProvider.refreshUser();
      //initialising the user state when app is opened
      authMethods.setUserState(userProvider.getUser.uid, UserState.Online);

      LogRepository.init(
        true,
        userProvider.getUser.uid,
      );
    });

    WidgetsBinding.instance.addObserver(this); //adding an observer

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance
        .removeObserver(this); //removes observer when home screen is disposed
  }

//helps keep track of the app lifecycle using the observer. We utilise this to create the functionality of the online presence indicator
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? authMethods.setUserState(currentUserId, UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? authMethods.setUserState(currentUserId, UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState
          .paused: //if the user is not interacting with the app even though it is open
        currentUserId != null
            ? authMethods.setUserState(currentUserId, UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? authMethods.setUserState(currentUserId, UserState.Offline)
            : print("detached state");
        break;
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
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
            LogScreen(),
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
                      fontSize: _labelFontSize,
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
                      fontSize: _labelFontSize,
                      color: (_page == 1) ? klightBlueColor : kgreyColor,
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
