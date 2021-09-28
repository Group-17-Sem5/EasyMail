import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:flutter/material.dart';
import 'package:easy_mail_app_frontend/model/mailModel.Dart';
import 'package:get/get.dart';

class UserMailBox extends StatefulWidget {
  const UserMailBox({Key? key}) : super(key: key);
  static const String route = '/user/mailBox';
  @override
  _UserMailBoxState createState() => _UserMailBoxState();
}

class _UserMailBoxState extends State<UserMailBox> {
  bool isLoading = false;
  String type = "sentMails";
  var selectedMail = <MailModel>[].obs;
  var userController = new UserController();
  void initState() {
    getReceivedMails("default");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: postmanAppBar(context),
        drawer: postManDrawer(context),
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
                            width: 100,
                            child:
                                Text('selectedMail[0].receiverID.toString()')),
                        Container(
                            width: 100,
                            child:
                                Text('selectedMail[0].addressID.toString()')),
                        Container(
                            width: 100,
                            child: Text('selectedMail[0].senderID.toString()')),
                        Container(
                            width: 100,
                            child:
                                Text('selectedMail[0].isDelivered.toString()')),
                        IconButton(
                            tooltip: "Deliver",
                            icon: Icon(Icons.check),
                            color: Colors.black,
                            hoverColor: Colors.white,
                            onPressed: () {
                              // deliverMail(
                              //     userController.sentMails[index].mailID);
                            }),
                        IconButton(
                            tooltip: "Cancelled",
                            icon: Icon(Icons.block),
                            color: Colors.black,
                            hoverColor: Colors.white,
                            onPressed: () {
                              //banEvent(event.eventID);
                            }),
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
              } else if (userController.sentMails.isEmpty) {
                return Text('Empty List');
              } else {
                return ListView.builder(
                  itemCount: userController.sentMails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(
                          context, userController.sentMails[index], index),
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
          // ListTile(
          //   title: Text(mail.mailID.toString()),
          //   onTap: () {
          //     tapped(
          //       mail.mailID.toString(),
          //     );
          //     print(mail.mailID.toString());
          //   },
          // ),
          Container(width: 100, child: Text('mail.mailID')),
          // Container(width: 100, child: Text(mail.isDelivered.toString())),
          // Container(width: 100, child: Text(mail.addressID.toString())),
          // Container(width: 100, child: Text(mail.receiverID.toString())),
          // // Container(width: 100, child: Text(tag.subscriber.toString())),
          // SizedBox(),
          IconButton(
              tooltip: "view",
              icon: Icon(Icons.check_circle),
              color: Colors.black,
              hoverColor: Colors.white,
              onPressed: () {
                // isTouched = true;
                // selectedMail.add(postManController.mails.value[index]);
                //acceptEvent(event.eventID, index);
              }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     tooltip: "edit",
          //     icon: Icon(Icons.drive_file_rename_outline),
          //     color: Colors.black,
          //     hoverColor: Colors.white,
          //     onPressed: () {
          //       //editEvent(event.eventID, index);
          //     }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     tooltip: "UnBan",
          //     icon: Icon(Icons.check),
          //     color: Colors.black,
          //     hoverColor: Colors.white,
          //     onPressed: () {
          //       //unBanEvent(event.eventID);
          //     }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     tooltip: "Ban",
          //     icon: Icon(Icons.block),
          //     color: Colors.black,
          //     hoverColor: Colors.white,
          //     onPressed: () {
          //       //banEvent(event.eventID);
          //     }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     tooltip: "Delete forever",
          //     icon: Icon(Icons.delete),
          //     color: Colors.black,
          //     hoverColor: Colors.white,
          //     onPressed: () {
          //       //deleteEvent(event.writerID, event.eventID);
          //     }),
        ],
      ),
    );
  }

  Future getReceivedMails(String userName) async {
    await userController.getReceivedMails(userName);
    return;
  }
}
