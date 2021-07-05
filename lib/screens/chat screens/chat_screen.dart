import 'dart:io';

import 'package:an_agile_squad/backend/firebase_repository.dart';
import 'package:an_agile_squad/constants/strings.dart';
import 'package:an_agile_squad/enum/view_state.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/message.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/provider/image_upload_provider.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:an_agile_squad/widgets/app_bar.dart';
import 'package:an_agile_squad/widgets/cached_image.dart';
import 'package:an_agile_squad/widgets/modal_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final Client receiver;

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();
  Client sender;
  String _currentUserID;
  bool isWriting = false;
  FirebaseRepository _repository = FirebaseRepository();
  ScrollController _listScrollController = ScrollController();
  bool showEmojiPicker = false;
  FocusNode textFieldFocus = FocusNode();
  ImageUploadProvider _imageUploadProvider;

  @override
  void initState() {
    super.initState();

    _repository.getCurrentUser().then((user) {
      _currentUserID = user.uid;

      setState(() {
        sender = Client(
          uid: user.uid,
          name: user.displayName,
          profilePhoto: user.photoURL,
        );
      });
    });
  }

  showKeyboard() => textFieldFocus.requestFocus();
  hideKeyboard() => textFieldFocus.unfocus();
  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    return Scaffold(
      backgroundColor: kblackColor,
      appBar: customAppBar(context),
      body: Column(
        children: <Widget>[
          Flexible(
            child: messageList(),
          ),
          _imageUploadProvider.getViewState == ViewState.LOADING
              ? Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 15),
                  child: CircularProgressIndicator(),
                )
              : Container(),
          chatControls(),
          showEmojiPicker ? Container(child: emojiContainer()) : Container(),
        ],
      ),
    );
  }

  emojiContainer() {
    return EmojiPicker(
      bgColor: kseparatorColor,
      indicatorColor: kblueColor,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting =
              true; //shows send button when emoji is typed and this enables us to send emojis!
        });

        textFieldController.text = textFieldController.text +
            emoji.emoji; //appending emoji to the currently typed text
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 50,
    );
  }

  //displays the list of messages that the user sends
  Widget messageList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kmessagesCollection)
          .doc(_currentUserID)
          .collection(widget.receiver.uid)
          .orderBy(ktimeStampField, descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //a callback which is called after a frame is rendered and it is called exactly once in its lifetime.But, if some changes are made to the UI, then the frame is rendered once again and the callback is called. This is used for automatically scrolling to the bottom of the chat screen on recieving a message,or while typing a message.
        // SchedulerBinding.instance.addPostFrameCallback((_) {
        //   _listScrollController.animateTo(
        //     _listScrollController.position
        //         .minScrollExtent, //minScrollExtent scrolls it to the bottom of the list
        //     duration: Duration(milliseconds: 250),
        //     curve: Curves.easeInOut,
        //   );
        // });

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: snapshot.data.docs.length,
          reverse: true,
          controller: _listScrollController,
          itemBuilder: (context, index) {
            return chatMessageItem(snapshot.data.docs[index]);
          },
        );
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        //aligning the messages sent and recieved
        alignment: _message.senderId == _currentUserID
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserID
            ? senderLayout(_message)
            : receiverLayout(_message),
      ),
    );
  }

//layout of messages being sent
  Widget senderLayout(Message message) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.65), //this ensures that any message takes up a maximum of 65% of screen width only
      decoration: kMessageDisplayDecor,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  getMessage(Message message) {
    //handles the display of image type messages
    return message.type != kmessageTypeImage
        ? Text(
            message.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          )
        : message.photoUrl != null
            ? CachedImage(url: message.photoUrl)
            : Text("Url was null");
  }

//layout of messages being received
  Widget receiverLayout(Message message) {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: kreceiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: getMessage(message),
      ),
    );
  }

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

//function to display media options in the bottom sheet
    addMediaModal(context) {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: kblackColor,
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Content and tools",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ModalTile(
                        title: "Media",
                        subtitle: "Share Photos and Video",
                        icon: Icons.image,
                        onTap: () => pickImage(
                          ImageSource.gallery,
                        ),
                      ),
                      ModalTile(
                          title: "File",
                          subtitle: "Share files",
                          icon: Icons.tab),
                      ModalTile(
                          title: "Contact",
                          subtitle: "Share contacts",
                          icon: Icons.contacts),
                      ModalTile(
                          title: "Location",
                          subtitle: "Share a location",
                          icon: Icons.add_location),
                      ModalTile(
                          title: "Schedule Call",
                          subtitle: "Arrange a skype call and get reminders",
                          icon: Icons.schedule),
                      ModalTile(
                          title: "Create Poll",
                          subtitle: "Share polls",
                          icon: Icons.poll)
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          //to display a bottom sheet on tapping the '+' icon
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: kfabGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: textFieldController,
                  focusNode: textFieldFocus,
                  onTap: () => hideEmojiContainer(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  //to display send icon to the right of the textfield when user starts typing a message
                  //makes sure that user isn't sending empty messages
                  onChanged: (val) {
                    (val.length > 0 &&
                            val.trim() !=
                                "") //trim function trims all blank spaces typed by the user to a blank message
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: kTextMessageInputDecor,
                ),
                IconButton(
                  
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    if (!showEmojiPicker) {
                      hideKeyboard();
                      showEmojiContainer();
                    } else {
                      hideEmojiContainer();
                      showKeyboard();
                    }
                  },
                  icon: Icon(Icons.face),
                ),
              ],
            ),
          ),
          //these icons are displayed only when the user is not typing
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.record_voice_over),
                ),
          isWriting
              ? Container()
              : GestureDetector(
                  onTap: () => pickImage(ImageSource.camera),
                  child: Icon(Icons.camera_alt),
                ),

          //the send button which appears when user begins typing
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: kfabGradient, shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    onPressed: () => sendMessage(),
                  ))
              : Container()
        ],
      ),
    );
  }

  pickImage(ImageSource source) async {
    File selectedImage = await Utils.pickImage(source);
    _repository.uploadImage(
        image: selectedImage,
        receiverId: widget.receiver.uid,
        senderId: _currentUserID,
        imageUploadProvider: _imageUploadProvider);
  }

  sendMessage() {
    var text = textFieldController.text; //gets the text being entered

    Message _message = Message(
      receiverId: widget.receiver.uid,
      senderId: sender.uid,
      message: text,
      timestamp: Timestamp.now(),
      type: 'text',
    );

    setState(() {
      isWriting = false;
    });
    text = "";
    _repository.addMessageToDb(_message, sender, widget.receiver);
  }

  CustomAppBar customAppBar(context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        widget.receiver.name,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.video_call,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.phone,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
