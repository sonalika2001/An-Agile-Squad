import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/screens/call%20screens/pickup%20screens/pickup_layout.dart';
import 'package:an_agile_squad/widgets/log%20widgets/floating_column.dart';
import 'package:an_agile_squad/widgets/log%20widgets/log_list_container.dart';
import 'package:an_agile_squad/widgets/app%20bars/general_app_bar.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: kblackColor,
        appBar: GeneralAppBar(
          title: "Calls",
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, "/search_screen"),
            ),
          ],
        ),
        floatingActionButton: FloatingColumn(),
        body: Padding(
          padding: EdgeInsets.only(left: 15),
          child: LogListContainer(),
        ),
      ),
    );
  }
}