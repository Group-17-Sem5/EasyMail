import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:easy_mail_app_frontend/model/moneyOrderModel.dart';
import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
import 'package:easy_mail_app_frontend/shared_widgets/customerDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/postManDrawer.dart';
import 'package:easy_mail_app_frontend/shared_widgets/searchBox.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MailsUserPage extends StatefulWidget {
  MailsUserPage({Key? key}) : super(key: key);
  static const String route = '/user/mailsUser';

  @override
  _MailsUserPageState createState() => _MailsUserPageState();
}

class _MailsUserPageState extends State<MailsUserPage> {
  //var _searchController = FloatingSearchBarController();
  var userController = new UserController();
  RefreshController _refreshController = RefreshController();
  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);
  //var searchResult = '';
  bool isLoading = false;
  bool isSearched = false;
  bool isTouched = false;

  var selectedMail = <MailModel>[].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //List mails = ["mail1", "mail2", "mail3"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: postmanAppBar(context),
        drawer: userDrawer(context),
        body: bottomNavBar(),
      ),
    );
  }

  Widget bottomNavBar() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [deliveredMailScreen(), sentMailScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.mail_solid),
        title: ("Received"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(0),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.arrow_up_circle_fill),
        title: ("Sent"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        //onPressed: _getCouriersList(1),
      ),
    ];
  }

  Widget deliveredMailScreen() {
    getMails(0);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text(
          "Mails For you",
          style: GoogleFonts.laila(fontSize: 22),
        ),
        tableHeading(),
        receivedTileList(),
      ]),
    ));
  }

  Widget sentMailScreen() {
    getMails(1);
    return Expanded(
        child: Container(
      child: Column(children: [
        Text(
          "Mails sent by You",
          style: GoogleFonts.laila(fontSize: 22),
        ),
        tableHeading(),
        sentTileList(),
      ]),
    ));
  }

  Widget sentTileList() {
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
                return Text('No Sent Mails Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userController.sentMails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(context,
                          userController.sentMails.value[index], index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget receivedTileList() {
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
              } else if (userController.receivedMails.isEmpty) {
                return Text('No Received Mails Yet',
                    style: GoogleFonts.laila(fontSize: 12));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userController.receivedMails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: tagCard(context,
                          userController.receivedMails.value[index], index),
                    );
                  },
                );
              }
            }),
    );
  }

  Widget tableHeading() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 50,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Sender",
                      style: GoogleFonts.laila(
                          fontSize: 14, fontWeight: FontWeight.bold)))),
        ),
        Expanded(
          child: Container(
              height: 50,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("From the branch",
                      style: GoogleFonts.laila(
                          fontSize: 14, fontWeight: FontWeight.bold)))),
        ),
        // Expanded(
        //   child: Container(
        //       height: 40,
        //       color: Colors.lightGreen,
        //       child: Padding(
        //           padding: EdgeInsets.all(5.0), child: Text("Special Code"))),
        // ),
        Expanded(
          child: Container(
              height: 50,
              color: Colors.lightGreen,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Delivery status",
                      style: GoogleFonts.laila(
                          fontSize: 14, fontWeight: FontWeight.bold)))),
        ),
        Container(height: 50, width: 50, color: Colors.lightGreen),
        // Expanded(
        //   child: Text("Address Description"),
        // ),
        // Expanded(child: Text("Mail Id"),),
      ],
    );
  }

  Widget tagCard(BuildContext context, MailModel mail, int index) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(bottom: 2),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Container(
              width: 100,
              child:
                  Text(mail.senderId, style: GoogleFonts.laila(fontSize: 14))),
          //Container(width: 100, child: Text(mail.isDelivered.toString())),
          Container(
              width: 100,
              child: Text(mail.sourceBranchId.toString(),
                  style: GoogleFonts.laila(fontSize: 14))),
          Container(
              width: 100,
              child: Text(mail.isDelivered.toString(),
                  style: GoogleFonts.laila(fontSize: 14))),
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
                selectedMail.add(mail);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'Mail Details',
                      style: GoogleFonts.laila(fontSize: 18),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              width: 300,
                              child: Text("Sender ID : " +
                                  selectedMail[0].senderId.toString())),
                          Container(
                              width: 300,
                              child: Text("Receiver ID : " +
                                  selectedMail[0].receiverId.toString())),
                          Container(
                              width: 300,
                              child: Text("Last appeared: " +
                                  selectedMail[0]
                                      .lastAppearedBranchId
                                      .toString())),
                          Container(
                              width: 300,
                              child: Text("Delivery Status: " +
                                  selectedMail[0].isDelivered.toString())),
                          Container(
                              width: 300,
                              child: Text("Assigned PostMan: " +
                                  selectedMail[0].postManId.toString())),
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
                          // _refreshController.requestRefresh();
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
  getMails(int num) {
    if (num == 1) {
      getSentMailsList();
    } else {
      getReceivedMailsList();
    }
  }

  Future getSentMailsList() async {
    var msg = await userController.getSentMails();

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    // _refreshController.loadComplete();
  }

  Future getReceivedMailsList() async {
    var msg = await userController.getReceivedMails();

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$msg')));
    // _refreshController.loadComplete();
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
