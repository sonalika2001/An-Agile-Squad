import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//contains call methods
class CallMethods {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection(kcallConnection);

//listens to any changes made inside the call collection document of the receiver, this is used for the pickup screen
  Stream<DocumentSnapshot> callStream({String uid}) =>
      callCollection.doc(uid).snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);//to be sent to caller's document

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);//to be sent to receiver's document

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Call call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}