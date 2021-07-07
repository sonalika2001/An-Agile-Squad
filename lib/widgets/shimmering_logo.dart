import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Image(
        image: AssetImage("assets/logo.png"),
      ),
    );
  }
}
