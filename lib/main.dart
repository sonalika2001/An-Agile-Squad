import 'package:an_agile_squad/backend/firebase_repository.dart';
import 'package:an_agile_squad/screens/home_screen.dart';
import 'package:an_agile_squad/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';



void main() async {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title:"An Agile Squad",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _repository.getCurrentUser(),
        builder: (context,AsyncSnapshot<User> snapshot){
          //returns home screen if the user isn't logged in, else login screen
          if(snapshot.hasData){
            return HomeScreen();
          }
          else{
            return LoginScreen();
          }
        }
      ),
    );
  }
}
