import 'package:flutter/material.dart';
import 'package:skooleneducation/model/user_model.dart';
import 'package:skooleneducation/pages/register_page.dart';
import 'package:skooleneducation/screens/homepagenew.dart';
import 'package:skooleneducation/service/addEditUser.dart';
import 'package:skooleneducation/service/user_service.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late List<UserModel> userList;
  bool loading = true;

  getAllUser() async {
    userList = await UserService().getUser();
    setState(() {
      loading = false;
    });
    print("user : ${userList.length}");
  }

  @override
  void initState() {
    super.initState();
    getAllUser();
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
              ).then((value) => getAllUser());
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
              itemCount: userList.length,
              itemBuilder: (context, index) {
                UserModel user = userList[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditUser(
                          userModel: user,
                          index: index,
                        ),
                      ),
                    ).then((value) => getAllUser());
                  },
                  leading: CircleAvatar(child: Text(user.nm_barang[0])),
                  title: Text(user.nm_barang),
                  subtitle: Text(user.stok),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ),
                );
              },
            ),
    );
  }
}
