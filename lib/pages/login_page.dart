// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_is_empty, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:skooleneducation/pages/register_page.dart';

import 'condition_policy_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _btnEmailActive = false;
  bool _btnPasswordActive = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      var url = "http://localhost:8888/localconnect/login.php";
      var response = await http.post(
        Uri.parse(url),
        body: {
          "username": _usernameController.text,
          "password": _passwordController.text,
        },
      );
      var data = json.decode(response.body);
      if (data == "Success") {
        Fluttertoast.showToast(
          msg: "Berhasil Masuk",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[500],
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConditionPolicy(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Username atau password salah!",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[500],
        );
      }
    } catch (e) {
      print(e);
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
          'Masuk',
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
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => onboardingPage(),
            //   ),
            // );
          },
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
                scale: 4,
              ),

              // login icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/login_icon.png", scale: 7),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Yay! Kamu kembali
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yay! Kamu kembali',
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
                      'Yuk, lanjutin belajar di Skoolen untuk capai tujuanmu.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Masukkin E-Mail
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

              // Username
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
                    hintText: 'Maksimal 15 Karakter',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _btnEmailActive = value.length >= 1 && value.length <= 15
                          ? true
                          : false;
                    });
                  },
                ),
              ),
              SizedBox(height: 15),

              // Kata Sandi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      'Kata Sandi',
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
                      _btnPasswordActive = value.length >= 5 ? true : false;
                    });
                  },
                ),
              ),

              SizedBox(height: 20),

              // Lupa kata sandi
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      child: Text(
                        "Lupa kata sandi?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xff00B1D2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ForgotPassword();
                        //     },
                        //   ),
                        // );
                      },
                      style: TextButton.styleFrom(
                        disabledBackgroundColor: Colors.amber,
                        backgroundColor: Colors.grey[200],
                        foregroundColor: const Color(0xff00b1d2),
                        side: BorderSide(width: 0, color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Masuk",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _btnEmailActive && _btnPasswordActive == true
                      ? signIn
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

              SizedBox(height: 30),

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

              SizedBox(height: 30),

              // Belum punya akun? Daftar Sekarang
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
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
                          'Daftar Sekarang',
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
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

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

              SizedBox(height: 75),
            ],
          ),
        ),
      ),
    );
  }
}
