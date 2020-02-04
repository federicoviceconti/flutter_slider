import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;

  PhoneFrame({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/phone_frame.png"),
              fit: BoxFit.fitHeight,
            )
          ),
        ),
      ],
    );
  }
}