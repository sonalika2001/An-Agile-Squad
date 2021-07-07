import 'package:an_agile_squad/backend/auth_methods.dart';
import 'package:an_agile_squad/enum/user_state.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final AuthMethods _authMethods = AuthMethods();

  OnlineDotIndicator({
    @required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    //decides color according to state value
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors
              .orange; //this is displayed when the user state is null as well as when the user is idle
      }
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: StreamBuilder<DocumentSnapshot>(
        stream: _authMethods.getUserStream(
          uid,
        ),
        builder: (context, snapshot) {
          Client user;

          if (snapshot.hasData && snapshot.data.data() != null) {
            user = Client.fromMap(snapshot.data.data());
          }

          return Container(
            height: 11,
            width: 11,
            margin: EdgeInsets.only(right: 5, top: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getColor(user?.state),
            ),
          );
        },
      ),
    );
  }
}
