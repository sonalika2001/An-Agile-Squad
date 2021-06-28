//contains definitions of all firebase related functions
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async{
    User currentUser;
    currentUser = await _auth.currentUser;
    return currentUser;
  }
}