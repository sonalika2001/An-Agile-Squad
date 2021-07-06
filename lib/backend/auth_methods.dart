import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StorageReference _storageReference;

  Client client = Client();
  static final CollectionReference _userCollection =
      firestore.collection(kusersCollection);

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = await _auth.currentUser;
    return currentUser;
  }

  Future<Client> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();

    return Client.fromMap(documentSnapshot.data());
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
        .collection(kusersCollection)
        .where(kemailField, isEqualTo: user.email)
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
        .collection(kusersCollection)
        .doc(currentUser.uid)
        .set(client.toMap(client));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  //for search functionality
//we pass user as argument so that we donot display the user's details when he/she searches for other users
  Future<List<Client>> fetchAllUsers(User currentUser) async {
    List<Client> userList = List<Client>();

    QuerySnapshot querySnapshot =
        await firestore.collection(kusersCollection).get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != currentUser.uid) {
        userList.add(Client.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return userList;
  }
}
