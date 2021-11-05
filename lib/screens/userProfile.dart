// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:easy_mail_app_frontend/controller/postManController.dart';
// import 'package:easy_mail_app_frontend/shared_widgets/AppBar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_mail_app_frontend/model/userModel.dart';
// import 'package:easy_mail_app_frontend/screens/editProfilePage.dart';
// import 'package:easy_mail_app_frontend/shared_widgets/userAppbar.dart';
// // import 'package:user_profile_ii_example/utils/user_preferences.dart';
// // import 'package:user_profile_ii_example/widget/appbar_widget.dart';
// // import 'package:user_profile_ii_example/widget/button_widget.dart';
// // import 'package:user_profile_ii_example/widget/numbers_widget.dart';
// import 'package:easy_mail_app_frontend/shared_widgets/profile_widget.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
//   static const String route = '/postMan/profile';
// }

// class _ProfilePageState extends State<ProfilePage> {
//   PostManController postManController = new PostManController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Builder(
//         builder: (context) => Scaffold(
//           appBar: userAppBar(context),
//           body: ListView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               ProfileWidget(
//                 imagePath:
//                     'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
//                 onClicked: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => EditProfilePage()),
//                   );
//                 },
//               ),
//               const SizedBox(height: 24),
//               //buildName(postManController.postMan.userName),
//               const SizedBox(height: 24),
//               //Center(child: buildUpgradeButton()),
//               const SizedBox(height: 24),
//               //NumbersWidget(),
//               const SizedBox(height: 48),
//               //buildAbout(postManController.postMan.area),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildName(UserModel user) => Column(
//         children: [
//           Text(
//             "default",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "default",
//             style: TextStyle(color: Colors.grey),
//           )
//         ],
//       );

//   // Widget buildUpgradeButton() => ButtonWidget(
//   //       text: 'Upgrade To PRO',
//   //       onClicked: () {},
//   //     );

//   Widget buildAbout(UserModel user) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 48),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'About',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "defalult",
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//           ],
//         ),
//       );

//   Widget buildBranch(UserModel user) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 48),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'About',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "defalult",
//               style: TextStyle(fontSize: 16, height: 1.4),
//             ),
//           ],
//         ),
//       );
// }
