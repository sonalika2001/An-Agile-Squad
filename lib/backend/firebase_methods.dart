//contains definitions of all firebase related functions
import 'dart:io';

import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/message.dart';
import 'package:an_agile_squad/provider/image_upload_provider.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseMethods {
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
        await firestore.collection(kusersCollection).get();
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
        .collection(kmessagesCollection)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    
    return await firestore
        .collection(kmessagesCollection)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on

    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      StorageUploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask.onComplete).ref.getDownloadURL(); //to upload url so that we can access the image file anywhere
      
      return url;
    } catch (e) {
      return null;
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await firestore
        .collection(kmessagesCollection)
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    firestore
        .collection(kmessagesCollection)
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  void uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);
  
    // Hide loading
    imageUploadProvider.setToIdle();

    setImageMsg(url, receiverId, senderId);
  }

  
}

//firebaseUser - User
// User - Client
// documents - doc 
// getDocuments - get 
// documentID - Id 
// data - data()