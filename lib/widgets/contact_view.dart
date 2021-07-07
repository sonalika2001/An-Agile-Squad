import 'package:an_agile_squad/backend/auth_methods.dart';
import 'package:an_agile_squad/backend/chat_methods.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/models/contact.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/screens/chat%20screens/chat_screen.dart';
import 'package:an_agile_squad/widgets/cached_image.dart';
import 'package:an_agile_squad/widgets/custom_tile.dart';
import 'package:an_agile_squad/widgets/last_message_container.dart';
import 'package:an_agile_squad/widgets/online_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final AuthMethods authMethods = AuthMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client>(
      future: authMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Client user = snapshot.data;

          return ViewLayout(
            user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final Client contact;
  final ChatMethods chatMethods = ChatMethods();

  ViewLayout(this.contact);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiver: contact,
          ),
        ),
      ),
      title: Text(
        contact?.name ??
            '..', //contact?.name is the same as if(contact!=null) return contact else return null
        //its called a conditional member access operator
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: chatMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(uid: contact.uid),
          ],
        ),
      ),
      
    );
  }
}
