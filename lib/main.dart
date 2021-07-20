import 'package:easy_mail_app_frontend/screens/homePage.dart';
import 'package:easy_mail_app_frontend/screens/postManLogin.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: MyHomePage.route,
      routes: {
        MyHomePage.route: (context) => MyHomePage(title: 'easyMail'),
        PostManLogin.route: (context) => PostManLogin(),
        // SeekerManaging.route: (context) => SeekerManaging(),
        // WriterManaging.route: (context) => WriterManaging(),
        // PrivateTagManaging.route: (context) => PrivateTagManaging(),
        // EventManaging.route: (context) => EventManaging(),
      },
      //home: MyHomePage(title: 'Easy Mail'),
    );
  }
}
