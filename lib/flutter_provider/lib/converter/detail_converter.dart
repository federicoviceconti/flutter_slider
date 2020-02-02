import 'dart:convert';

import 'package:flutter_slider/flutter_provider/lib/model/shoe_detail.dart';

ShoeDetail convertResponseToDetailShoesItems(String body) {
  var decodedBody = jsonDecode(body);
  var shoe = decodedBody['result'];
  return ShoeDetail(
    shoe['id'],
    shoe['brand'],
    shoe['model'],
    shoe['price'],
    "assets/nike_shoe.png",
    description: shoe['detail'],
    title: shoe['title']
  );
}