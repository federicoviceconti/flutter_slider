import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final Color backgroundColor;

  RoundButton(this.width, this.height, this.icon, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildRoundButton(
        this.width, this.height, icon, this.backgroundColor);
  }

  Padding buildRoundButton(
      double width, double height, IconData icon, Color backgroundColor) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
            width: width,
            height: height,
            child: IconButton(
              padding: EdgeInsets.only(right: 0.0),
              color: Colors.black,
              icon: Icon(icon),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15.0,
                  spreadRadius: -5.0,
                  offset: Offset(
                    -1.0, // horizontal, move right -1
                    2.0, // vertical, move down 2
                  ),
                )
              ],
            )));
  }
}
