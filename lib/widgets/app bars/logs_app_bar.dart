import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/widgets/app%20bars/app_bar.dart';
import 'package:an_agile_squad/widgets/info%20providers/coming_soon.dart';
import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;
  final List<Widget> actions;

  const GeneralAppBar({
    Key key,
    @required this.title,
    @required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet(
        context: context,
        backgroundColor: kblackColor,
        builder: (context) => ComingSoon(),
      );
        },
      ),
      title: (title is String)
          ? Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : title,
      centerTitle: true,
      actions: actions,
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}