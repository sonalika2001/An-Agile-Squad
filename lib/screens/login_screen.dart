import 'package:an_agile_squad/backend/auth_methods.dart';
import 'package:an_agile_squad/backend/chat_methods.dart';
import 'package:an_agile_squad/backend/storage_methods.dart';
import 'package:an_agile_squad/screens/home_screen.dart';
import 'package:an_agile_squad/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginPressed = false;
   AuthMethods authMethods = AuthMethods();
  StorageMethods storageMethods = StorageMethods();
  ChatMethods chatMethods = ChatMethods();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblackColor,
      body: Stack(
        children: [
          Center(
            child: loginButton(),
          ),
          isLoginPressed
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: ksenderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        onPressed: () => executeLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void executeLogin() {

    setState(() {
      isLoginPressed = true;
    });
    authMethods.signIn().then((User user) {
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(User user) {
    authMethods.authenticateUser(user).then((isNewUser) {

      setState(() {
        isLoginPressed = false;
      });
      
      if (isNewUser) {
        authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      }
    });
  }
}
