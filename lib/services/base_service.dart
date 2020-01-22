import 'package:http/http.dart';

import 'api.dart';

abstract class BaseService {
  Api api;

  BaseService(this.api);

  bool isOk(Response it) => it.statusCode == 200 && it.body.isNotEmpty;
}