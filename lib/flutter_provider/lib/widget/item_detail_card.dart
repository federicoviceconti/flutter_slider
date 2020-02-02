import 'package:flutter/material.dart';

class ItemDetailCard extends StatelessWidget {
  final Image image;
  final Color backgroundColor;
  final bool isVideo;

  ItemDetailCard(this.image, {this.backgroundColor, this.isVideo});

  @override
  Widget build(BuildContext context) {
    return ItemDetail(image, backgroundColor, isVideo);
  }

  Padding ItemDetail(Image image, Color backgroundColor, bool isVideo) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          width: 100,
          height: 50,
          child: Stack(children: CreateStack(image, isVideo)),
          decoration: new BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));
  }

  List<Widget> CreateStack(Image image, bool isVideo) {
    List<Widget> list = new List();
    list.add(
        Container(height: 100, width: 100, child: IconButton(icon: image)));

    if (isVideo) {
      list.add(Container(height: 100, width: 100, child: Icon( Icons.play_circle_filled, size: 50,), decoration: new BoxDecoration(
        color: Color.fromARGB(170, 203, 202, 203),
        borderRadius: BorderRadius.circular(5.0),
      ),));
    }
    return list;
  }
}
