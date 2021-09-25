import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:easy_mail_app_frontend/model/userModel.dart';
import 'package:easy_mail_app_frontend/shared_widgets/textfield_widget.dart';
import 'package:easy_mail_app_frontend/shared_widgets/button_widget.dart';
import 'package:easy_mail_app_frontend/model/userModel.dart';
import 'package:easy_mail_app_frontend/shared_widgets/profile_widget.dart';
import 'package:easy_mail_app_frontend/controller/postManController.dart';
// import 'package:user_profile_ii_example/utils/user_preferences.dart';
// import 'package:user_profile_ii_example/widget/appbar_widget.dart';
// import 'package:user_profile_ii_example/widget/button_widget.dart';
// import 'package:user_profile_ii_example/widget/profile_widget.dart';
// import 'package:user_profile_ii_example/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
  static const String route = '/postMan/profileEdit';
}

class _EditProfilePageState extends State<EditProfilePage> {
  //UserModel user = new UserModel();
  PostManController postManController = new PostManController();
  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: postManController.postMan.userName,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: postManController.postMan.mobileNumber,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: postManController.postMan.area,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: postManController.postMan.branchID,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ],
            ),
          ),
        ),
      );
}
