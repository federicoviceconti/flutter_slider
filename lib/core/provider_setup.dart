import 'package:flutter_slider/flutter_provider/lib/service/api.dart';
import 'package:flutter_slider/flutter_provider/lib/service/navigator_service.dart';
import 'package:flutter_slider/services/api.dart';
import 'package:flutter_slider/services/slider_service.dart';
import 'package:provider/provider.dart';

setupProviderServices() {
  var api = Provider(create: (ctx) => Api());
  var service = ProxyProvider<Api, SliderService>(update: (_, api, __) => SliderService(api: api));
  var navigator = Provider.value(value: NavigatorService());
  var apiProvider = Provider.value(value: ApiProvider());
  return [
    navigator,
    apiProvider,
    api,
    service
  ];
}