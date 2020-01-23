import 'package:flutter_slider/core/config.dart';
import 'package:flutter_slider/services/api.dart';
import 'package:flutter_slider/services/mock_client.dart';
import 'package:http/http.dart';

import 'custom_client.dart';

abstract class AbsClient implements HttpClientInterface {
  static buildClient() {
    if(Config.environment != Environment.MOCK) {
      return CustomClient(environment: Config.environment);
    }

    return MockClient();
  }
}

abstract class HttpClientInterface {
  Future<Response> get<T>(String path);
}