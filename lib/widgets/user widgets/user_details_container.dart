import 'package:an_agile_squad/backend/firebase%20methods/auth_methods.dart';
import 'package:an_agile_squad/enum/user_state.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/screens/login_screen.dart';
import 'package:an_agile_squad/widgets/app%20bars/custom_app_bar.dart';
import 'package:an_agile_squad/widgets/logo%20widgets/app_logo.dart';
import 'package:an_agile_squad/widgets/user%20widgets/user_details_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsContainer extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    signOut() async {
      final bool isLoggedOut = await authMethods.signOut();
      if (isLoggedOut) {
        // set userState to offline as the user logs out
        authMethods.setUserState(
          userProvider.getUser.uid,
          UserState.Offline,
        );

        // moves the user to login screen and removes all previous screens,so that the back button doesn't allow the user to go back into the app
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          CustomAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.maybePop(context),
            ),
            centerTitle: true,
            title: AppLogo(),
            actions: <Widget>[
              FlatButton(
                onPressed: () => signOut(),
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
          UserDetailsBody(),
        ],
      ),
    );
  }
}
