import 'package:flutter_slider/core/config.dart';
import 'package:flutter_slider/services/client.dart';
import 'package:http/http.dart';

class Api {
  AbsClient client;
  
  Api(): client = AbsClient.buildClient();

  Future<Response> getSlide() {
    return client.get(ClientPath.SLIDES_PATH);
  }
  
}

enum Environment { DEV, COLL, PROD, MOCK }