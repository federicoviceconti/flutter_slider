import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_slider/core/config.dart';
import 'package:http/http.dart';
import 'client.dart';

class MockClient extends AbsClient {
  @override
  Future<Response> get<T>(String path) {
    return _buildResponseOnPath(path);
  }

  Future<Response> _buildResponseOnPath(String path) async {
    var body = await _getMockFromAsset(path);
    return Response(body, 200, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });
  }

  _getMockFromAsset(path) async {
    var firstPartPath = "assets/json";

    if(path == ClientPath.SLIDES_PATH) {
      return await rootBundle.loadString("$firstPartPath/slides.json");
    }

    throw new Exception("Network mock not found! Path: $firstPartPath/$path");
  }
}