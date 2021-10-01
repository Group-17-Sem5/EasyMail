import 'package:easy_mail_app_frontend/model/postManModel.dart';
import 'package:easy_mail_app_frontend/model/userModel.dart';
import 'package:get/get.dart';
import '../model/mailModel.Dart';
import '../model/addressModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var sentMails = <MailModel>[].obs;
  var receivedMails = <MailModel>[].obs;
  UserModel postMan = new UserModel();
  static String? token;
  static String? userName;

  Future register(String details) async {
    return;
  }

  Future login(String username, String password) async {
    userName = username;
    return;
  }

  Future getSentMails(String userName) async {
    return;
  }

  Future getSentMoneyOrders(String mailID) async {
    return;
  }

  Future getReceivedMoneyOrders(String mailID) async {
    return;
  }

  Future getReceivedMails(String userName) async {
    return;
  }

  Future changeMyAddressID(String addressID) async {
    return;
  }
}
