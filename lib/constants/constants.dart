import 'package:flutter/material.dart';

//constant variables in flutter are conventianally named with a 'k' as the prefix
const Color kblueColor = Color(0xff505AC9);
const Color kblackColor = Color(0xff19191b);
const Color kgreyColor = Color(0xff8f8f8f);
const Color kuserCircleBackground = Color(0xff2b2b33);
const Color konlineDotColor = Color(0xff46dc64);
const Color klightBlueColor = Color(0xff7B83EB);
const Color kseparatorColor = Color(0xff272c35);
const Color kdarkBlueColor = Color(0xff464EB8);
const Color kgradientColorStart = Color(0xff7B83EB);
const Color kgradientColorEnd = Color(0xff464EB8);

const Color ksenderColor = Color(0xff464EB8);
const Color kreceiverColor = Color(0xff1e2225);

Gradient kfabGradient = LinearGradient(
    colors: [kgradientColorStart, kgradientColorEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

BoxDecoration kUserCircleDecor = BoxDecoration(
  borderRadius: BorderRadius.circular(50),
  color: kseparatorColor,
);

InputDecoration kTextMessageInputDecor = InputDecoration(
  hintText: "Type a message",
  hintStyle: TextStyle(
    color: kgreyColor,
  ),
  border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(50.0),
      ),
      borderSide: BorderSide.none),
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  filled: true,
  fillColor: kseparatorColor,
);

Radius kmessageRadius = Radius.circular(10);

BoxDecoration kMessageDisplayDecor = BoxDecoration(
  color: ksenderColor,
  borderRadius: BorderRadius.only(
    topLeft: kmessageRadius,
    topRight: kmessageRadius,
    bottomLeft: kmessageRadius,
  ),
);
