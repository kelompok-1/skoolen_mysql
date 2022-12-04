import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skooleneducation/pages/login_page.dart';

import 'condition_policy_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool _btnUsernameActive = false;
  bool _btnEmailActive = false;
  bool _btnPasswordActive = false;
  bool _btnPasswordConfirmActive = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future signUp() async {
    try {
      var url = "http://localhost:8888/localconnect/register.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "username": _usernameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        },
      );
      var data = json.decode(response.body);
      if (data == "Error") {
        Fluttertoast.showToast(
          msg: "Username telah terdaftar",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[500],
        );
      } else {
        Fluttertoast.showToast(
          msg: "Username berhasil didaftarkan",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[500],
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "ups, ada yang salah");
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _passwordConfirmController.text.trim()) {
      signUp();
      return true;
    } else {
      Fluttertoast.showToast(
        msg: "Kata sandi nggak sama",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey[500],
      );
      return false;
    }
  }

  // hexa colors
  Color HexaColor(String strcolor, {int opacity = 15}) {
    //opacity is optional value
    strcolor = strcolor.replaceAll("#", ""); //replace "#" with empty value
    String stropacity =
        opacity.toRadixString(16); //convert integer opacity to Hex String
    return Color(int.parse("$stropacity$stropacity" + strcolor, radix: 16));
    //here color format is 0xFFDDDDDD, where FF is opacity, and DDDDDD is Hex Color
  }

  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar
      appBar: AppBar(
        title: Text(
          'Daftar',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          splashRadius: 19,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              // Logo
              Image.asset(
                "assets/images/Logo Biru.png",
                scale: 3,
              ),
              // login icon
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Image.asset("assets/images/login_icon.png", scale: 7),
              //     ],
              //   ),
              // ),

              SizedBox(height: 10),

              // Yay! Kamu kembali
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Semua bisa cerdas',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),

              // Yuk, lanjutin belajar di Skoolen untuk capai tujuanmu.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Di Skoolen cara belajarnya beda. Yuk, cobain!',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Username',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Username Textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  cursorColor: const Color(0xffFDDB27),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_2,
                      color: Color(0xff00B1D2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00B1D2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Maksimal 15 karakter',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _btnUsernameActive =
                          value.length >= 1 && value.length <= 15
                              ? true
                              : false;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              // Masukkin E-Mail atau Nomor HP
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  cursorColor: const Color(0xffFDDB27),
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_2,
                      color: Color(0xff00B1D2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00B1D2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Ketik di sini',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _btnEmailActive = value.length >= 1 ? true : false;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),

              // Kata Sandi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Kata sandi',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              // Kata Sandi textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  cursorColor: const Color(0xffFDDB27),
                  controller: _passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xff00B1D2),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00B1D2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Minimal 6 karakter',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _btnPasswordActive = value.length >= 6 ? true : false;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              // Kata Sandi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Konfirmasi kata sandi',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              // Kata Sandi textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  cursorColor: const Color(0xffFDDB27),
                  controller: _passwordConfirmController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xff00B1D2),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff00B1D2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Masukkin sandi yang sama',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _btnPasswordConfirmActive =
                          value.length >= 6 ? true : false;
                    });
                  },
                ),
              ),

              SizedBox(height: 10),

              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Daftar",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _btnEmailActive &&
                          _btnPasswordActive &&
                          _btnPasswordConfirmActive &&
                          _btnUsernameActive == true
                      ? passwordConfirmed
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xff00b1d2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            color: Colors.black,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Udah punya akun? Masuk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Udah punya akun?',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      // highlightColor: Colors.amber,
                      highlightColor: Color(0x1000B1D2),
                      splashColor: Color(0x4000B1D2),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Masuk',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Color(0xff00b1d2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Syarat Ketentuan & Kebijakan Privasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Dengan masuk atau daftar Skoolen, saya menyetujui : ',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      // highlightColor: Colors.amber,
                      highlightColor: Color(0x1000B1D2),
                      splashColor: Color(0x4000B1D2),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Syarat Ketentuan & Kebijakan Privasi',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Color(0xff00b1d2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConditionPolicy(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
