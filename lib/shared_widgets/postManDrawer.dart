import 'package:easy_mail_app_frontend/screens/postManScreens/cancelledMailPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/deliveredmailPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/mailListPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/marker.dart';
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
            child: ListTile(
                title: Text(
                  //controller,
                  "Post Man",
                  style: GoogleFonts.laila(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  print("Going to profile page");
                }),
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
          title: Text('My Assigned Mails'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MailListPage()));
          },
        ),
        ListTile(
          title: Text('My delivered Mails'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DeliveredMailPage()));
          },
        ),
        ListTile(
          title: Text('My Cancelled Mails'),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CancelledMailPage()));
          },
        ),
        // ListTile(
        //   title: Text('Public Tag Controller'),
        //   onTap: () {
        //     // Update the state of the app.
        //     // ...
        //   },
        // ),
        // ListTile(
        //   title: Text('Notification Controller'),
        //   onTap: () {
        //     // Update the state of the app.
        //     // ...
        //   },
        // ),
        // ListTile(
        //   title: Text('Event Controller'),
        //   onTap: () {
        //     // Navigator.of(context).pushReplacement(
        //     //     MaterialPageRoute(builder: (context) => EventManaging()));
        //   },
        // ),
      ],
    ),
  );
}
