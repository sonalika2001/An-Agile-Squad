//a medium to communicate with firebase methods

import 'package:an_agile_squad/backend/firebase_methods.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.currentUser();

  Future<User> getSignIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(User user) => _firebaseMethods.addDataToDb(user);

  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<Client>> fetchAllUsers(User user) => _firebaseMethods.fetchAllUsers(user);
}
