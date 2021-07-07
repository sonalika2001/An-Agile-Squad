import 'package:an_agile_squad/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: kblackColor,
        highlightColor: Colors.white,
        child: Image.asset("assets/an_agile_squad.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}