import 'dart:math';

import 'package:an_agile_squad/backend/call_methods.dart';
import 'package:an_agile_squad/models/call.dart';
import 'package:an_agile_squad/models/client.dart';
import 'package:an_agile_squad/screens/call%20screens/call_screen.dart';
import 'package:flutter/material.dart';

//calls the appropriate methods to required to make a call and passes the required caller/receiver info
class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Client from, Client to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(), //random number b/w 0-1000
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true; //helps the call screen differentiate between the caller and receiver

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}