import 'package:flutter_slider/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'client.dart';

/// @class CustomClient
/// 
/// This class contains the creation of base url and their creations.
/// This one is based on Environment, which you can change and configure
/// with build type.
/// 
/// You can expand as you want.
class CustomClient extends AbsClient {
  String baseUrl;

  CustomClient({Environment environment}) {
    _createBaseUrl(environment);
  }

  @override
  Future<Response> get<T>(String path) {
    return http.get(_createUrl(path));
  }

  _createUrl(url) => baseUrl + url;

  /// You can specify your urls here for every environment you want
  void _createBaseUrl(Environment environment) {
    switch(environment) {
      case Environment.DEV:
        this.baseUrl = "http://0.0.0.0:9090/api/";
        break; 
      case Environment.COLL:
        this.baseUrl = "";
        break;
      case Environment.PROD:
        this.baseUrl = "";
        break;
      case Environment.MOCK:
        this.baseUrl = "";
        break;
    }
  }
}