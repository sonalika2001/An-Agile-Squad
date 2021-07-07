import 'dart:io';

import 'package:an_agile_squad/backend/local%20db/interface/log_interface.dart';
import 'package:an_agile_squad/models/log.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

//hive is a really fast and powerful NoSQL database.It stores data in boxes. 
class HiveMethods implements LogInterface {
  String hiveBox = "";

  @override
  openDb(dbName) => (hiveBox = dbName);

  @override
  init() async {
    Directory dir = await getApplicationDocumentsDirectory(); //returns the directory where the data will be stored 
    Hive.init(dir.path);
  }

  @override
  addLogs(Log log) async {
    var box = await Hive.openBox(hiveBox);

    var logMap = log.toMap(log);

    int idOfInput = await box.add(logMap); //records are auto-indexed. Can modify the index/key by using the put() method instead.

    close();

    return idOfInput;
  }

  updateLogs(int index, Log newLog) async {
    var box = await Hive.openBox(hiveBox);

    var newLogMap = newLog.toMap(newLog);

    box.putAt(index, newLogMap);

    close();
  }

  @override
  Future<List<Log>> getLogs() async {
    var box = await Hive.openBox(hiveBox);

    List<Log> logList = [];

    for (int i = 0; i < box.length; i++) {
      var logMap = box.getAt(i);

      logList.add(Log.fromMap(logMap));
    }
    return logList;
  }

  @override
  deleteLogs(int logId) async {
    var box = await Hive.openBox(hiveBox);

    await box.deleteAt(logId);
    
  }

  @override
  close() => Hive.close();
}