import 'package:an_agile_squad/backend/local%20db/db/hive_methods.dart';
import 'package:an_agile_squad/backend/local%20db/db/sqflite_methods.dart';
import 'package:an_agile_squad/models/log.dart';

//determines which database is to be used
class LogRepository {
  static var dbObject;
  static bool isHive;

  static init(bool isHive, String dbName) {
    dbObject = isHive ? HiveMethods() : SqliteMethods();
    dbObject.openDb(dbName);
    dbObject.init();
  }

  static addLogs(Log log) => dbObject.addLogs(log);

  static deleteLogs(int logId) => dbObject.deleteLogs(logId);

  static getLogs() => dbObject.getLogs();

  static close() => dbObject.close();
}
