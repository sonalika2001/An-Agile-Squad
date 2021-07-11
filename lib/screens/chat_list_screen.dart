import 'package:an_agile_squad/backend/firebase%20methods/auth_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/chat_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/storage_methods.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/models/contact.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/widgets/user%20widgets/contact_view.dart';
import 'package:an_agile_squad/widgets/app%20bars/general_app_bar.dart';
import 'package:an_agile_squad/widgets/chat%20widgets/new_chat_button.dart';
import 'package:an_agile_squad/widgets/info%20providers/quiet_box.dart';
import 'package:an_agile_squad/widgets/user%20widgets/user_circle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();
  final StorageMethods storageMethods = StorageMethods();
  final ChatMethods chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblackColor,
      appBar: GeneralAppBar(
        title: UserCircle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search_screen');
            },
          ),
        ],
      ),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(),
    );
  }
}

//these contain the chat list members
class ChatListContainer extends StatelessWidget {
  final ChatMethods chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: chatMethods.fetchContacts(userId: userProvider.getUser.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.docs;

              if (docList.isEmpty) {
                return QuietBox(
                  "This is where all your chats are listed.",
                  "Search for your friends and family to start calling or chatting with them!",
                );
              } else
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: docList.length,
                  itemBuilder: (context, index) {
                    Contact contact = Contact.fromMap(docList[index].data());
                    return ContactView(contact);
                  },
                );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kdarkBlueColor,
                valueColor: new AlwaysStoppedAnimation<Color>(klightBlueColor),
              ),
            );
          }),
    );
  }
}
