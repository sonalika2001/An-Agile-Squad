import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//contains chat methods
class ChatMethods{
  
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Client client = Client();
 

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


}