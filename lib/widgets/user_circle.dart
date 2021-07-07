import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/provider/user_provider.dart';
import 'package:an_agile_squad/utils/utilities.dart';
import 'package:an_agile_squad/widgets/user_details_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//circular widget as title of app bar which displays the parsed initials of the user
class UserCircle extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: kblackColor,
        builder: (context) => UserDetailsContainer(),
      ),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kseparatorColor,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                Utils.getInitials(userProvider.getUser.name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: klightBlueColor,
                  fontSize: 13,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: kblackColor, width: 2),
                  color: konlineDotColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
