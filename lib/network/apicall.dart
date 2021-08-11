import 'dart:convert';

import 'package:flutterapp/network/Api.dart';
import 'package:http/http.dart';

import '../usersmodel.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<dynamic> getUsers() async {
    Uri url = Uri.parse('http://jsonplaceholder.typicode.com/users');
    final response = await get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      List<UserModel> userList = [];
      for (Map map in data) {
        userList.add(UserModel.fromJson(map));
      }
      print(userList.length);
      return userList.take(5).toList();
    } else {
      return null;
    }
  }
}
