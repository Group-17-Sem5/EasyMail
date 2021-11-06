import 'package:easy_mail_app_frontend/screens/postManScreens/postManLogin.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String route = '/';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/postMan.jpg', width: 150, height: 150),
            Text(
              'Easy mail',
              style: GoogleFonts.laila(
                fontSize: 38,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.black),
                backgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              onPressed: () {
                startAsPostMan();
              },
              icon: Icon(
                Icons.account_box_rounded,
              ),
              label: Text(
                'I am a post man',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.blue),
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                onPressed: () {
                  startAsCustomer();
                },
                icon: Icon(
                  Icons.account_box,
                ),
                label: Text(
                  'I am a user',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startAsPostMan() {
    print("started as postman ");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => PostManLogin()));
  }

  startAsCustomer() {
    print('start as customer');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => UserLogin()));
  }
}
