import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/movie.dart';
import '../model/service.dart';
import 'movie_details_screen.dart';

class HomeNew extends StatefulWidget {
  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: service().getProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: movieList.length,
                    // itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Movie movie = movieList[index];
                      var mydata = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          title: Text(mydata['nm_barang']),
                          subtitle: Text(movie.year.toString()),
                          leading: Image.network(mydata["gambar"]),
                          trailing: Icon(Icons.arrow_forward_rounded),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailsScreen(movie)));
                          },
                        ),
                      );
                      // return ListTile(
                      //   title: Text(mydata['nm_barang']),
                      // );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
