import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/customerDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/searchBox.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:easy_mail_app_frontend/controller/appBinding.dart';
import 'package:easy_mail_app_frontend/model/mailModel.Dart';

class ReceivedMailPage extends StatefulWidget {
  ReceivedMailPage({Key? key}) : super(key: key);
  static const String route = '/user/receivedMailList';

  @override
  _ReceivedMailPageState createState() => _ReceivedMailPageState();
}

class _ReceivedMailPageState extends State<ReceivedMailPage> {
  //var _searchController = FloatingSearchBarController();
  var userController = new UserController();
  //var searchResult = '';
  bool isLoading = false;
  bool isSearched = false;
  bool isTouched = false;

  var selectedMail = <MailModel>[].obs;
  @override
  void initState() {
    // TODO: implement initState

    getMailsList();
    super.initState();
  }

  //List mails = ["mail1", "mail2", "mail3"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: postmanAppBar(context),
        drawer: userDrawer(context),
        body: Container(
          color: Color(0xFFE0FAEA),
          child: Column(
            children: <Widget>[
              Expanded(
                child: tileList(),
              ),
              Expanded(child: mailDetail()),
            ],
          ),
        ),
      ),
    );
  }

  Widget mailDetail() {
    setState(() {
      //String result = getResult();
      //print(result);
    });
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                children: [
                  Text("Loading data.."),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Obx(() {
              if (isLoading) {
                return Text('Loading');
              } else if (selectedMail.length == 0) {
                return Text('Select a Mail to Show details');
              } else {
                return ListView.builder(
                  itemCount: selectedMail.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Column(
                      children: [
                        Container(
                            width: 300,
                            child: Text("Receiver id : " +
                                selectedMail[0].receiverId.toString())),
                        Container(
                            width: 300,
                            child: Text("Address ID : " +
                                selectedMail[0].addressId.toString())),
                        Container(
                            width: 300,
                            child: Text("Sender ID : " +
                                selectedMail[0].senderId.toString())),
                        Container(
                            width: 300,
                            child: Text("Delivery Status: " +
                                selectedMail[0].isDelivered.toString())),
                        // Row(
                        //   children: [
                        //     IconButton(
                        //         tooltip: "Deliver",
                        //         icon: Icon(Icons.check),
                        //         color: Colors.black,
                        //         hoverColor: Colors.white,
                        //         onPressed: () {
                        //           deliverMail(selectedMail[0].mailId);
                        //         }),
                        //     IconButton(
                        //         tooltip: "Cancel",
                        //         icon: Icon(Icons.block),
                        //         color: Colors.black,
                        //         hoverColor: Colors.white,
                        //         onPressed: () {
                        //           cancelDelivery(selectedMail[0].mailId);
                        //         }),
                        //   ],
                        // ),
                      ],
                    ));
                  },
                );
              }
            }),
    );
  }

  Widget tileList() {
    return Expanded(
      child: isLoading
          ? Center(
              child: Column(
                children: [
                  Text("Loading data.."),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Obx(() {
              if (isLoading) {
                return Text('Loading');
              } else if (userController.mails.isEmpty) {
                return Text('Empty List');
              } else {
                return ListView.builder(
                  itemCount: userController.mails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(
                          context, userController.mails.value[index], index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget tagCard(BuildContext context, MailModel mail, int index) {
    return Container(
      height: 40,
      color: Colors.greenAccent,
      child: Row(
        children: [
          Container(width: 100, child: Text(mail.mailId)),
          //Container(width: 100, child: Text(mail.isDelivered.toString())),
          Container(width: 100, child: Text(mail.receiverId.toString())),
          Container(width: 100, child: Text(mail.senderId.toString())),
          // // Container(width: 100, child: Text(tag.subscriber.toString())),
          // SizedBox(),
          IconButton(
              tooltip: "view",
              icon: Icon(Icons.mail),
              color: Colors.black,
              hoverColor: Colors.white,
              onPressed: () {
                isTouched = true;
                selectedMail.clear();
                selectedMail.add(userController.mails.value[index]);
              }),
        ],
      ),
    );
  }

  //methods

  Future getMailsList() async {
    await userController.getReceivedMails();
  }

  // Future deliverMail(String mailID) async {
  //   var result = await postManController.confirmDelivery(mailID);
  //   if (result.err == 0) {
  //     var msg = result.msg;
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('$msg')));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
  //   }
  // }

  // Future cancelDelivery(String mailID) async {
  //   var result = await postManController.cancelDelivery(mailID);
  //   if (result.err == 0) {
  //     var msg = result.msg;
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('$msg')));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
  //   }
  // }
}
