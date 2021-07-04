//contains definitions of all firebase related functions
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/message.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Client client = Client();

  Future<User> currentUser() async {
    User currentUser;
    currentUser =_auth.currentUser;
    return currentUser;
  }

  Future<User> signIn() async {
    //Starts the interactive sign-in process and returns a Future instance i.e the user's response
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    //retrieves the credentials of the user
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken,
    );

    //signs in the user with the entered credentials
    UserCredential authResult = await _auth.signInWithCredential(credential);
    User user = authResult.user;
    return user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    //if user is registered then list size > 0 else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email);
    client = Client(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoURL,
      username: username,
    );
    firestore
        .collection("users")
        .doc(currentUser.uid)
        .set(client.toMap(client));
  }

  Future<void> signOut() async{
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

//for search functionality
//we pass user as argument so that we donot display the user's details when he/she searches for other users
  Future<List<Client>> fetchAllUsers(User currentUser) async {
    List<Client> userList = List<Client>();

    QuerySnapshot querySnapshot =
        await firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id!= currentUser.uid) {
        userList.add(Client.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }

//messages in firebase db are stored in this order:
//collection(named messages)->documents of user id(senders, recievers etc.)->collections of user ids that each user has been chatting with->collections of messages, each containing various fields such as message, user id, sender id,timestamp etc.
  Future<void> addMessageToDb(
      Message message, Client sender, Client receiver) async {
    var map = message.toMap();

    await firestore
        .collection("messages")
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    
    return await firestore
        .collection("messages")
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }
}

//firebaseUser - User
// User - Client
// documents - doc 
// getDocuments - get 
// documentID - Id 
// data - data()