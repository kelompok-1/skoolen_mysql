import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
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
      appBar: AppBar(
        title: Text('Movies o watch'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<List>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data!.map(
                  (data) {
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(data["nm_barang"]),
                        subtitle: Text("jumlah : ${data["stok"]}"),
                        leading: Image.network(data["gambar"]),
                        trailing: Icon(Icons.arrow_forward_rounded),
                        onTap: () {
                          print(snapshot.data!.length.toString());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             DetailPage(index)));
                        },
                      ),
                    );
                  },
                ).toList(),
              );
            return Text("Loading...");
          },
        ),
      ),
    );
  }
}
