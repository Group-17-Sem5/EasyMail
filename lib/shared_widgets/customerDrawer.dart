import 'package:easy_mail_app_frontend/screens/postManScreens/marker.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/couriers-user.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/mails-user.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/moneyOrders.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userMailBox.dart';
import 'package:easy_mail_app_frontend/screens/userProfile.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userSentMails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget userDrawer(BuildContext context) {
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
                "User",
                style: GoogleFonts.laila(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                print("Showing the profile");
              },
            ),
          ),
        ),
        // ListTile(
        //   tileColor: Color(0xFF69F8C1),
        //   title: Text('My Mail Box'),
        //   onTap: () {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => ReceivedMailPage()));
        //   },
        // ),
        // ListTile(
        //   title: Text('Sent Mails'),
        //   onTap: () {
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => UserSentMailPage()));
        //   },
        // ),
        ListTile(
          title: Text(
            'Mails',
            style: GoogleFonts.laila(fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MailsUserPage()));
          },
        ),
        ListTile(
          title: Text(
            'Money Orders',
            style: GoogleFonts.laila(fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MoneyOrdersPage()));
          },
        ),
        ListTile(
          title: Text(
            'Couriers',
            style: GoogleFonts.laila(fontSize: 18),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CouriersUser()));
          },
        ),
      ],
    ),
  );
}
