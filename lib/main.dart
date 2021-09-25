import 'package:easy_mail_app_frontend/screens/editProfilePage.dart';
import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:easy_mail_app_frontend/screens/locationPage.dart';
import 'package:easy_mail_app_frontend/screens/mailListPage.dart';
import 'package:easy_mail_app_frontend/screens/marker.dart';
import 'package:easy_mail_app_frontend/screens/postManLogin.dart';
import 'package:easy_mail_app_frontend/screens/userLogin.dart';
import 'package:easy_mail_app_frontend/screens/userProfile.dart';
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
      initialRoute: ProfilePage.route,
      routes: {
        MyHomePage.route: (context) => MyHomePage(title: 'Easy Mail'),
        PostManLogin.route: (context) => PostManLogin(),
        MailListPage.route: (context) => MailListPage(),
        AddressLocation.route: (context) => AddressLocation(),
        PlaceMarkerBody.route: (context) => PlaceMarkerBody(),
        ProfilePage.route: (context) => ProfilePage(),
        EditProfilePage.route: (context) => EditProfilePage(),
        UserLogin.route: (context) => UserLogin(),

        // WriterManaging.route: (context) => WriterManaging(),
        // PrivateTagManaging.route: (context) => PrivateTagManaging(),
        // EventManaging.route: (context) => EventManaging(),
      },
      //home: MyHomePage(title: 'Easy Mail'),
    );
  }
}
