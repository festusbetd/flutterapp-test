import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:http/http.dart';

import '../usersmodel.dart';

class API {
  static postRequest(
    String function,
  ) async {
    Uri url = Uri.parse('http://jsonplaceholder.typicode.com/$function');
    Map<String, String> header = {
      "Content-Type": "application/json; charset=utf-8"
    };

    Response response = await get(url);
    final network_response = jsonDecode(response.body);
    print(function + "--Response-->${network_response}");

    try {
      switch (response.statusCode) {
        case 401:
          print("Auth error");
          break;
        case 200:
          ApiResults.results = network_response;

          break;

        default:
          print("unable to connect");
          break;
      }
    } catch (Exception) {}
  }
}

class ApiResults {
  static var results;
}
