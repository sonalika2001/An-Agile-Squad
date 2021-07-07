import 'package:an_agile_squad/models/log.dart';

abstract class LogInterface {
  openDb(dbName);

  init();

  addLogs(Log log);

  // returns a list of logs
  Future<List<Log>> getLogs();

  deleteLogs(int logId);

  close(); //must close so that when a different account is logged into the same device, the call logs are of that account only
}