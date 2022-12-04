import 'dart:convert';

import 'package:http/http.dart' as http;

class service {
  String url = "http://localhost:8888/localconnect/ambildata.php";
  Future getProducts() async {
    var response = await http.get(Uri.parse(url));

    var product = json.decode(response.body);
    return product;
    // print(e);
  }
}
