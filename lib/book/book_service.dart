import 'dart:convert';

import 'package:skooleneducation/book/book_model.dart';
import 'package:http/http.dart' as http;

class BookService {
  // static const ADD_URL = "http://localhost:8888/localconnect/add.php";
  static const VIEW_URL =
      "http://courseapp.wstif3c.id/restapi_skoolen/book/get_book.php";
  // static const UPDATE_URL = "http://localhost:8888/localconnect/update.php";
  // Future<String> addBook(BookModel bookModel) async {
  //   final response =
  //       await http.post(Uri.parse(ADD_URL), body: bookModel.toJsonAdd());
  //   if (response.statusCode == 200) {
  //     print("Add Response : " + response.body);
  //     return response.body;
  //   } else {
  //     return "Error";
  //   }
  // }

  List<BookModel> bookFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<BookModel>.from(data.map((item) => BookModel.fromJson(item)));
  }

  Future<List<BookModel>> getBook() async {
    final response = await http.get(Uri.parse(VIEW_URL));
    if (response.statusCode == 200) {
      List<BookModel> list = bookFromJson(response.body);
      return list;
    } else {
      return <BookModel>[];
    }
  }

  // Future<String> updateUser(BookModel bookModel) async {
  //   final response =
  //       await http.post(Uri.parse(UPDATE_URL), body: bookModel.toJsonUpdate());
  //   if (response.statusCode == 200) {
  //     print("Add Response : " + response.body);
  //     return response.body;
  //   } else {
  //     return "Error";
  //   }
  // }
}
