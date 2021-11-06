import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/searchBox.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:easy_mail_app_frontend/controller/appBinding.dart';
import 'package:easy_mail_app_frontend/model/mailModel.Dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MailListPage extends StatefulWidget {
  MailListPage({Key? key}) : super(key: key);
  static const String route = '/postMan/mailList';

  @override
  _MailListPageState createState() => _MailListPageState();
}

class _MailListPageState extends State<MailListPage> {
  //var _searchController = FloatingSearchBarController();
  var postManController = new PostManController();
  RefreshController _refreshController = RefreshController();
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
        drawer: postManDrawer(context, "Mails Assigned"),
        body: Container(
          color: Color(0xFFE0FAEA),
          child: Column(
            children: <Widget>[
              Container(height: 20),
              Text("The mails assiged",
                  style: GoogleFonts.laila(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
              Container(height: 20),
              tableHeading(),
              Expanded(
                flex: 3,
                child: tileList(),
              ),
              //Expanded(flex: 2, child: mailDetail()),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableHeading() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Address ID",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Receiver ID",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        Expanded(
          child: Container(
              height: 40,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Sender Id",
                      style: GoogleFonts.laila(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )))),
        ),
        Container(height: 40, width: 50, color: Colors.lightGreen),
        // Expanded(
        //   child: Text("Address Description"),
        // ),
        // Expanded(child: Text("Mail Id"),),
      ],
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
                    return AlertDialog(
                        title: const Text('AlertDialog Title'),
                        content: SingleChildScrollView(
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
                              Row(
                                children: [
                                  IconButton(
                                      tooltip: "Deliver",
                                      icon: Icon(Icons.check),
                                      color: Colors.black,
                                      hoverColor: Colors.white,
                                      onPressed: () {
                                        deliverMail(selectedMail[0].mailId);
                                      }),
                                  IconButton(
                                      tooltip: "Cancel",
                                      icon: Icon(Icons.block),
                                      color: Colors.black,
                                      hoverColor: Colors.white,
                                      onPressed: () {
                                        cancelDelivery(selectedMail[0].mailId);
                                      }),
                                ],
                              ),
                            ],
                          ),
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
              } else if (postManController.mails.isEmpty) {
                return Text('Empty List');
              } else {
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: getMailsList,
                  //onLoading: _onLoading,
                  enablePullUp: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: postManController.mails.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: tagCard(context,
                            postManController.mails.value[index], index),
                      );
                    },
                  ),
                );
              }
            }),
    );
  }

  Widget tagCard(BuildContext context, MailModel mail, int index) {
    return Container(
      height: 40,
      color: Colors.green.shade50,
      child: Row(
        children: [
          Container(width: 100, child: Text(mail.addressId)),
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
                selectedMail.add(postManController.mails.value[index]);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Mail Details'),
                    content: SingleChildScrollView(
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
                          Row(
                            children: [
                              IconButton(
                                  tooltip: "Deliver",
                                  icon: Icon(Icons.check),
                                  color: Colors.black,
                                  hoverColor: Colors.white,
                                  onPressed: () {
                                    deliverMail(selectedMail[0].mailId);
                                  }),
                              IconButton(
                                  tooltip: "Cancel",
                                  icon: Icon(Icons.block),
                                  color: Colors.black,
                                  hoverColor: Colors.white,
                                  onPressed: () {
                                    cancelDelivery(selectedMail[0].mailId);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      // TextButton(
                      //   onPressed: () => Navigator.pop(context, 'Cancel'),
                      //   child: const Text('Cancel'),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          _refreshController.requestRefresh();
                          _refreshController.loadComplete();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  //methods

  Future getMailsList() async {
    await postManController.getMails();
    _refreshController.loadComplete();
  }

  Future deliverMail(String mailID) async {
    _refreshController.requestRefresh();

    var result = await postManController.confirmDelivery(mailID);
    if (result.err == 0) {
      var msg = result.msg;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$msg')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
    }
    _refreshController.loadComplete();
  }

  Future cancelDelivery(String mailID) async {
    _refreshController.requestRefresh();

    var result = await postManController.cancelDelivery(mailID);
    if (result.err == 0) {
      var msg = result.msg;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$msg')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went Wrong ')));
    }
    _refreshController.loadComplete();
  }
}
