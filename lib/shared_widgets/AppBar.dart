import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar postmanAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'Easy Mail',
      textAlign: TextAlign.center,
      style: GoogleFonts.laila(
        fontSize: 34,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.logout_rounded),
        tooltip: 'Log Out',
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Logged out')));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyHomePage(title: "Easy Mail")));
        },
      ),
    ],
  );
}
