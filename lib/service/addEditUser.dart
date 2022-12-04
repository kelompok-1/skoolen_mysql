import 'package:flutter/material.dart';
import 'package:skooleneducation/book/book_model.dart';
import 'package:skooleneducation/model/user_model.dart';
import 'package:skooleneducation/service/user_service.dart';

class AddEditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  AddEditUser({required this.userModel, required this.index});

  @override
  State<AddEditUser> createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {
  TextEditingController nm_barang = TextEditingController();
  TextEditingController stok_barang = TextEditingController();
  bool editMode = false;
  add(UserModel userModel) async {
    await UserService().addUser(userModel).then((success) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      nm_barang.text = widget.userModel.nm_barang;
      stok_barang.text = widget.userModel.stok;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add")),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nm_barang,
              decoration: InputDecoration(hintText: 'Enter Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: stok_barang,
              decoration: InputDecoration(hintText: 'Enter Stok'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nm_barang.text.isEmpty) {
                print("field diperlukan");
              } else {
                UserModel userModel = UserModel(
                  nm_barang: nm_barang.text,
                  stok: stok_barang.text,
                );
                add(userModel);
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
