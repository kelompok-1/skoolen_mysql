import 'package:flutter/material.dart';
import 'package:skooleneducation/book/book_detail.dart';
import 'package:skooleneducation/book/book_model.dart';
import 'package:skooleneducation/model/user_model.dart';
import 'package:skooleneducation/pages/register_page.dart';
import 'package:skooleneducation/screens/homepagenew.dart';
import 'package:skooleneducation/service/addEditUser.dart';
import 'package:skooleneducation/service/user_service.dart';

import 'book_service.dart';

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  late List<BookModel> bookList;
  bool loading = true;

  getAllBook() async {
    bookList = await BookService().getBook();
    setState(() {
      loading = false;
    });
    print("book list : ${bookList.length}");
  }

  @override
  void initState() {
    super.initState();
    getAllBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Crud"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ).then((value) => getAllBook());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                BookModel book = bookList[index];
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetail(
                            bookModel: book,
                            index: index,
                          ),
                        ),
                      ).then((value) => getAllBook());
                    },
                    // leading: CircleAvatar(child: Text(book.nm_barang[0])),
                    title: Text(book.nm_barang),
                    subtitle: Text(book.stok + " Halaman"),
                    leading: Image.network(
                      book.gambar,
                      width: 50,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
    );
  }
}
