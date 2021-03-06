import 'package:flutter_slider/services/api.dart';

/// The config class contains the principal configuration based, for example,
/// on build type. You can here, every thing is related to configuration.
class Config {
  static Environment get environment {
    const env = String.fromEnvironment('environment');
    switch(env) {
      case 'coll':
        return Environment.COLL;
      case 'dev':
        return Environment.DEV;
      case 'prod':
        return Environment.PROD;
    }

    return Environment.MOCK;
  }
}

class ClientPath {
  static const String SLIDES_PATH = "slides";
}

class KeyCode {
  static int left = 123;
  static int right = 124;
  static int r = 15;

  static int f = 3;
}