import 'package:easy_mail_app_frontend/screens/marker.dart';
import 'package:easy_mail_app_frontend/screens/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget postManDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              //controller,
              "Post Man",
              style: GoogleFonts.laila(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ListTile(
          tileColor: Color(0xFF69F8C1),
          title: Text('Locations'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PlaceMarkerBody()));
          },
        ),
        ListTile(
          title: Text('User Profile'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
        ),
        ListTile(
          title: Text('Writer Controller'),
          onTap: () {
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => WriterManaging()));
          },
        ),
        ListTile(
          title: Text('Private Tag Controller'),
          onTap: () {
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => PrivateTagManaging()));
          },
        ),
        ListTile(
          title: Text('Public Tag Controller'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Notification Controller'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Event Controller'),
          onTap: () {
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => EventManaging()));
          },
        ),
      ],
    ),
  );
}
