import 'dart:convert';

import 'package:skooleneducation/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const ADD_URL = "http://localhost:8888/localconnect/add.php";
  static const VIEW_URL = "http://localhost:8888/localconnect/view.php";
  static const UPDATE_URL = "http://localhost:8888/localconnect/update.php";
  Future<String> addUser(UserModel userModel) async {
    final response =
        await http.post(Uri.parse(ADD_URL), body: userModel.toJsonAdd());
    if (response.statusCode == 200) {
      print("Add Response : " + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }

  List<UserModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }

  Future<List<UserModel>> getUser() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<UserModel> list = userFromJson(response.body);
      return list;
    } else {
      return <UserModel>[];
    }
  }

  Future<String> updateUser(UserModel userModel) async {
    final response =
        await http.post(Uri.parse(UPDATE_URL), body: userModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print("Add Response : " + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }
}
