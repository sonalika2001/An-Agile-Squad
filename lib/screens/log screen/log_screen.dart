import 'package:an_agile_squad/backend/local%20db/repository/log_repository.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/models/log.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblackColor,
      body: Center(
        child: FlatButton(
          child: Text("Click Me"),
          onPressed: () {
            LogRepository.init(false);
            LogRepository.addLogs(Log());
          },
        ),
      ),
    );
  }
}