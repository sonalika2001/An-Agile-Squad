import 'package:an_agile_squad/screens/page%20views/chat_list_screen.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;
  double _labelFontSize = 10;

  @override
  void initState() {
    
    super.initState();
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
    return Scaffold(
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
    );
  }
}
