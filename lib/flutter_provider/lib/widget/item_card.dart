import 'package:flutter/material.dart';
import 'package:flutter_slider/flutter_provider/lib/model/shoe.dart';
import 'package:flutter_slider/flutter_provider/lib/provider/home_notifier.dart';
import 'package:provider/provider.dart';

class ItemCardWidget extends StatelessWidget {
  final Shoe _itemCardModel;

  ItemCardWidget(this._itemCardModel);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (_, model, __) => GestureDetector(
        onTap: () {
          model.onItemPressed(_itemCardModel.id);
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16.0),
                height: 288,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _itemCardModel.brand.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: /*_itemCardModel.favorite
                                ? Icon(Icons.favorite)
                                :*/ Icon(Icons.favorite_border),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                    Text(
                      _itemCardModel.model.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      _itemCardModel.price.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Spacer(flex: 1),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        padding: EdgeInsets.all(4.0),
                        icon: Icon(Icons.arrow_forward),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 204.0,
                width: 204.0,
                margin: EdgeInsets.only(left: 16.0, top: 56.0),
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'shoe_image' + _itemCardModel.id.toString(),
                  child: Image.asset(_itemCardModel.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
