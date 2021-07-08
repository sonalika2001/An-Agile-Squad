import 'package:an_agile_squad/backend/firebase%20methods/auth_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/chat_methods.dart';
import 'package:an_agile_squad/backend/firebase%20methods/storage_methods.dart';
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
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 0.15 * MediaQuery.of(context).size.height),
            child: Text(
              "An Agile Squad",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: klightBlueColor,
                fontFamily: 'Exo 2',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: 0,
                top: 0 * MediaQuery.of(context).size.height,
                left: 5,
                right: 5),
            child: Image(
              image: AssetImage("assets/logo.png"),
              height: 0.4 * MediaQuery.of(context).size.height,
              width: 0.9 * MediaQuery.of(context).size.width,
            ),
          ),
          Stack(
            children: [
              Center(
                child: loginButton(),
              ),
              isLoginPressed
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kdarkBlueColor,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(klightBlueColor),
                      ),
                    )
                  : Container()
            ],
          ),
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
              fontSize: 35, fontWeight: FontWeight.w800, letterSpacing: 1.2),
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
