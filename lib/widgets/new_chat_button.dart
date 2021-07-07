import 'package:an_agile_squad/constants/constants.dart';
import 'package:flutter/material.dart';

//customised floating action button for beginning a new chat

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: kfabGradient, borderRadius: BorderRadius.circular(50)),
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/search_screen');
        },
        icon: Icon(
          Icons.edit,
        ),
        color: Colors.white,
        iconSize: 30,
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
