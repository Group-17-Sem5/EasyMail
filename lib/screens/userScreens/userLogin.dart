import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/mailListPage.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userMailBox.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key? key}) : super(key: key);
  static const String route = '/user/login';

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();
  UserController userController = new UserController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: postmanAppBar(context),
      resizeToAvoidBottomInset: true,
      //drawer: postManDrawer(context),
      body: Center(
        child: SingleChildScrollView(
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
                  emailField(),
                  SizedBox(height: 25.0),
                  passwordField(),
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon(),
                  cancelButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return (TextField(
      controller: _userNameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "user name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    ));
  }

  Widget passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget loginButon() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF014D30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          bool _validate = true;
          setState(() {
            _userNameController.text.isEmpty
                ? _validate = false
                : _validate = true;
          });
          if (_validate) {
            checkLogin(_userNameController.text, _passwordController.text);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('check the email again')));
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget cancelButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF000000),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyHomePage(title: "easy mail")));
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void checkLogin(String username, String password) async {
    try {
      var err = await userController.login(username, password);
      if (err == 0) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ReceivedMailPage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => UserLogin()));
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Check the details again')));
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
