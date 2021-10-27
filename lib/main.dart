import 'package:easy_mail_app_frontend/screens/register.dart';
import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/cancelledMailPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/deliveredmailPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/editAddressDetails.dart';

import 'package:easy_mail_app_frontend/screens/postManScreens/mailListPage.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/marker.dart';
import 'package:easy_mail_app_frontend/screens/postManScreens/postManLogin.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/moneyOrders.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userLogin.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userMailBox.dart';
import 'package:easy_mail_app_frontend/screens/userProfile.dart';
import 'package:easy_mail_app_frontend/screens/userScreens/userSentMails.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: MyHomePage.route,
      routes: {
        MyHomePage.route: (context) => MyHomePage(title: 'Easy Mail'),
        PostManLogin.route: (context) => PostManLogin(),
        MailListPage.route: (context) => MailListPage(),

        PlaceMarkerBody.route: (context) => PlaceMarkerBody(),
        // ProfilePage.route: (context) => ProfilePage(),
        RegisterProfilePage.route: (context) => RegisterProfilePage(),
        UserLogin.route: (context) => UserLogin(),
        UserSentMailPage.route: (context) => UserSentMailPage(),
        ReceivedMailPage.route: (context) => ReceivedMailPage(),
        CancelledMailPage.route: (context) => CancelledMailPage(),
        DeliveredMailPage.route: (context) => DeliveredMailPage(),
        EditAddressDetails.route: (context) => EditAddressDetails(),

        MoneyOrdersPage.route: (context) => MoneyOrdersPage(),
        // PrivateTagManaging.route: (context) => PrivateTagManaging(),
        // EventManaging.route: (context) => EventManaging(),
      },
      //home: MyHomePage(title: 'Easy Mail'),
    );
  }
}
