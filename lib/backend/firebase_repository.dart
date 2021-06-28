//a medium to communicate with firebase methods

import 'package:an_agile_squad/backend/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository{
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();
}