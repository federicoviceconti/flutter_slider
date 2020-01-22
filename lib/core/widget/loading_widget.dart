import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool show;

  const LoadingWidget({Key key, this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show ? Container(
      color: Color(0xAA000000),
      child: Center(
        child: CircularProgressIndicator()
      ),
    ) : Container();
  }

}