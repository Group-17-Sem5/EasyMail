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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
            RaisedButton(
              onPressed: () {
                startAsPostMan();
              },
              hoverColor: Colors.white,
              child: Text("Start as postMan"),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: RaisedButton(
                onPressed: () {
                  startAsCustomer();
                },
                hoverColor: Colors.white,
                child: Text("Start as Customer",
                    style: TextStyle(
                      decorationColor: Colors.white,
                    )),
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
