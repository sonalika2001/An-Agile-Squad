import 'dart:io';

import 'package:an_agile_squad/backend/chat_methods.dart';
import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/provider/image_upload_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

//contains storage methods
class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StorageReference _storageReference;

  Client client = Client();
  static final CollectionReference _userCollection =
      firestore.collection(kusersCollection);

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on

    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      StorageUploadTask storageUploadTask =
          _storageReference.putFile(imageFile);
      var url = await (await storageUploadTask.onComplete)
          .ref
          .getDownloadURL(); //to upload url so that we can access the image file anywhere

      return url;
    } catch (e) {
      return null;
    }
  }

  void uploadImage(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    final ChatMethods chatMethods = ChatMethods();
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
