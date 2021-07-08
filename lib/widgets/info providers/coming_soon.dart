import 'package:an_agile_squad/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: ksenderColor,
      period: Duration(milliseconds: 1200),
      child: Center(
        child: Text(
          "Coming Soon!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Exo 2',
          ),
        ),
      ),
    );
  }
}
