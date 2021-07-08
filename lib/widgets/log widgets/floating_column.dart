import 'package:an_agile_squad/constants/constants.dart';
import 'package:an_agile_squad/widgets/info%20providers/coming_soon.dart';
import 'package:flutter/material.dart';

class FloatingColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: kfabGradient,
          ),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kblackColor,
                builder: (context) => ComingSoon(),
              );
            },
            child: Icon(
              Icons.dialpad,
              color: Colors.white,
              size: 25,
            ),
          ),
          padding: EdgeInsets.all(15),
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kblackColor,
              border: Border.all(
                width: 2,
                color: kgradientColorEnd,
              )),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kblackColor,
                builder: (context) => ComingSoon(),
              );
            },
            child: Icon(
              Icons.add_call,
              color: kgradientColorEnd,
              size: 25,
            ),
          ),
          padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
