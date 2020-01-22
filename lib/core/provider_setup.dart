import 'package:flutter_slider/services/api.dart';
import 'package:flutter_slider/services/slider_service.dart';
import 'package:provider/provider.dart';

import 'config.dart';

setupProviderServices() {
  var api = Provider(create: (ctx) => Api(type: Config.environment));
  var service = ProxyProvider<Api, SliderService>(update: (_, api, __) => SliderService(api: api));
  
  return [
    api,
    service
  ];
}