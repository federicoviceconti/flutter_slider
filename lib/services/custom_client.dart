import 'package:flutter_slider/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CustomClient {
  String baseUrl;

  CustomClient({Environment environment}) {
    _createBaseUrl(this.baseUrl, environment);
  }

  Future<Response> get<T>(String path) {
    return http.get(_createUrl(path));
  }

  _createUrl(url) => baseUrl + url;

  void _createBaseUrl(String baseUrl, Environment environment) {
    switch(environment) {
      case Environment.MOCK:
        this.baseUrl = "http://0.0.0.0:9090/api/";
        break;
      case Environment.DEV:
        this.baseUrl = "";
        break; 
      case Environment.COLL:
        this.baseUrl = "";
        break;
      case Environment.PROD:
        this.baseUrl = "";
        break;
    }
  }
}