import 'package:flutter/material.dart';
import 'package:flutter_slider/flutter_provider/lib/provider/home_notifier.dart';
import 'package:provider/provider.dart';
import '../widget/item_card.dart';
import '../widget/item_filter.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      Provider.of<HomeNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBuildHomeWidget(context);
  }

  _buildBuildHomeWidget(BuildContext context) {
    var isLoading = Provider.of<HomeNotifier>(context).isLoading;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildBrands(),
            _buildItemList(),
          ],
        ),

        isLoading ? Container(
          child: Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ) : Container()
      ],
    );
  }

  _buildItemList() {
    return Container(
        height: 288.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildSideBrand(),
            _buildItems()
          ],
        ),
      );
  }

  _buildItems() {
    return Expanded(
      child: Consumer<HomeNotifier>(
        builder: (_, model, __) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.shoes.length,
        itemBuilder: (BuildContext listContext, int index) {
          var shoe = model.shoes[index];
          return ItemCardWidget(shoe);
        },
      ),
      ),
    );
  }

  _buildSideBrand() {
    return Consumer<HomeNotifier>(
      builder: (_, model, ___) => RotatedBox(
        quarterTurns: 1,
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          height: 32.0,
          child: model.shoes.length > 0 ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (BuildContext listContext, int index) {
              return GestureDetector(
                child: ItemFilterWidget("Featured", false),
                onTap: () {},
              );
            },
          ) : Container(),
        ),
      ),
    );
  }

  _buildBrands() {
    return Consumer<HomeNotifier>(
      builder: (_, model, ___) => Container(
        margin: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0, bottom: 8.0),
        height: 30.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.brands.length,
          itemBuilder: (BuildContext listContext, int index) {
            var item = model.brands[index];

            return GestureDetector(
              child: ItemFilterWidget(item.brand, item.selected), 
              onTap: () {
                model.selectBrand(index);
              }
            );
          },
        ),
      ),
    );
  }
}
