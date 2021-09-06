import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:easy_mail_app_frontend/screens/mailListPage.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'dart:convert';

class PostManLogin extends StatefulWidget {
  PostManLogin({Key? key}) : super(key: key);
  static const String route = '/postMan/login';

  @override
  _PostManLoginState createState() => _PostManLoginState();
}

class _PostManLoginState extends State<PostManLogin> {
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    @override
    final emailField = TextField(
      controller: _emailController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF014D30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          checkLogin(_emailController.text, _passwordController.text);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final cancelButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF000000),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          getData();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MailListPage()));
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: postmanAppBar(context),
      //drawer: postManDrawer(context),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 135.0,
                  child: Image.asset(
                    "assets/images/postMan.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                cancelButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(String email, String password) {
    print(email);
  }

  Future<String> getData() async {
    List data;
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {"accept": "applicati"});
    data = json.decode(response.body);

    print(data[1]["title"]);

    return "Success!";
  }
}
