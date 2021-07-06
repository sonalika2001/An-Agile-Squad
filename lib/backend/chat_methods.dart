import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/contact.dart';
import 'package:an_agile_squad/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatMethods{
  
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Client client = Client();
  final CollectionReference _messageCollection =
      firestore.collection(kmessagesCollection);

  final CollectionReference _userCollection =
      firestore.collection(kusersCollection);
 

  //messages in firebase db are stored in this order:
//collection(named messages)->documents of user id(senders, recievers etc.)->collections of user ids that each user has been chatting with->collections of messages, each containing various fields such as message, user id, sender id,timestamp etc.
  Future<void> addMessageToDb(
      Message message, Client sender, Client receiver) async {
    var map = message.toMap();

    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);
    
    //a new contact is added to chat list whenever a message is sent/received
     addToContacts(senderId: message.senderId, receiverId: message.receiverId);
    
    return await _messageCollection
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
    await _messageCollection
        .doc(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messageCollection
        .doc(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

   DocumentReference getContactsDocument({String of, String forContact}) =>
      _userCollection
          .doc(of)
          .collection(kcontactsCollection)
          .doc(forContact);

  addToContacts({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId, receiverId, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Future<void> addToSenderContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    //if the contact doesn't already exist in the chat list
    if (!senderSnapshot.exists) {
      
      Contact receiverContact = Contact(
        uid: receiverId,
        addedOn: currentTime,
      );

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .set(receiverMap);
    }
  }

  Future<void> addToReceiverContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .set(senderMap);
    }
  }

   Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
      .doc(userId)
      .collection(kcontactsCollection)
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    String senderId,
    String receiverId,
  }) =>
      _messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();


}