import 'package:flutter/material.dart';
import 'package:flutter_slider/flutter_provider/lib/model/brand.dart';
import 'package:flutter_slider/flutter_provider/lib/model/shoe.dart';
import 'package:flutter_slider/flutter_provider/lib/service/navigator_service.dart';
import 'package:flutter_slider/flutter_provider/lib/utility/route_constants.dart';

import 'base_notifier.dart';

class HomeNotifier extends BaseNotifier {
  NavigatorService navigatorService;

  HomeNotifier({@required this.navigatorService, @required api}): super(api);

  List<Brand> _brands = [];
  List<Brand> get brands => _brands;

  List<Shoe> _shoes = [];
  List<Shoe> _filteredShoes = [];
  List<Shoe> get shoes => hasFilter() == null ? _shoes : _filteredShoes;

  void init() {
    showLoader(show: true);

    api.getProductsAndBrands((shoesConverted, brandsConverted) {
      _shoes = shoesConverted;
      _brands = brandsConverted;
      notifyListeners();
      showLoader(show: false);
    });
  }

  void onItemPressed(int id) {
    showLoader(show: true);

    api.getDetails(id, (shoeDetail) {
      showLoader(show: false);
      navigatorService.navigateTo(RouteConstants.details, shoeDetail);
    });
  }

  void selectBrand(int index) {
    _brands = _brands.map((item) {
      var currentIdx = _brands.indexOf(item);
      item.selected =  !item.selected && index == currentIdx;
      return item;
    }).toList();

    var filter = hasFilter();

    if(filter != null) {
      _filteredShoes = _shoes.where((it) => it.brand == filter.brand).toList();
    }

    notifyListeners();
  }

  Brand hasFilter() => brands.firstWhere((it) => it.selected, orElse: () => null);
}