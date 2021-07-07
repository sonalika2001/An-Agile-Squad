import 'package:an_agile_squad/backend/auth_methods.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:flutter/material.dart';

//fetches the latest user details from firebase and notifies the listeners. Used for pickup layout.
class UserProvider with ChangeNotifier {
  Client _user;
  AuthMethods authMethods = AuthMethods();
  Client get getUser => _user;

  Future<void> refreshUser() async {
    Client user = await authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}