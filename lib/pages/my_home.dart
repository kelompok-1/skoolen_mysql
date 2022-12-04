import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  StreamController<List> _streamController = StreamController();
  late Timer _timer;

  Future _ambildata() async {
    var response = await http
        .get(Uri.parse("http://localhost:8888/localconnect/ambildata.php"));
    try {
      var dataBarang = jsonDecode(response.body);
      _streamController.add(dataBarang);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _ambildata();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) => _ambildata());
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<List>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data!.map((data) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(data["nm_barang"]),
                      subtitle: Text("jumlah : ${data["stok"]}"),
                    ),
                  );
                }).toList(),
              );
            return Text("Loading...");
          },
        ),
      ),
    );
  }
}
