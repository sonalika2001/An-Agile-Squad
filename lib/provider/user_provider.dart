import 'package:an_agile_squad/backend/firebase_repository.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:flutter/material.dart';

//fetches the latest user details from firebase and notifies the listeners. Used for pickup layout.
class UserProvider with ChangeNotifier {
  Client _user;
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  Client get getUser => _user;

  void refreshUser() async {
    Client user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }

}