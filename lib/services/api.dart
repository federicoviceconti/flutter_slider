import 'package:flutter_slider/core/config.dart';
import 'package:http/http.dart';
import 'custom_client.dart';

class Api {
  Environment type;
  CustomClient client;
  
  Api({this.type}): client = CustomClient(environment: Config.environment);

  Future<Response> getSlide() {
    return client.get("slides");
  }
  
}

enum Environment { DEV, COLL, PROD, MOCK }