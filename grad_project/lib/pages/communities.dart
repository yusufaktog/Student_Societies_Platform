import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';
import 'activities.dart';
import 'authorized_user.dart';
import 'main_page.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({Key? key}) : super(key: key);
  static const String routeName = '/communities';

  @override
  _CommunitiesPageState createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  var flexFactor = 5;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredAppBarHeight,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: flexFactor,
              child: CustomAppBarElement(
                state: this,
                routeName: AuthorizedUserPage.routeName,
                isUnderlined: false,
                text: "HOME PAGE",
                fontSize: 18,
              ),
            ),
            Expanded(
              flex: flexFactor,
              child: CustomAppBarElement(
                state: this,
                routeName: CommunitiesPage.routeName,
                isUnderlined: true,
                text: "COMMUNITIES",
                fontSize: 18,
              ),
            ),
            Expanded(
              flex: flexFactor - 1,
              child: CustomAppBarElement(
                state: this,
                routeName: ActivitiesPage.routeName,
                isUnderlined: false,
                text: "ACTIVITIES",
                fontSize: 18,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: mainBackGroundColor,
                child: IconButton(
                  iconSize: 30,
                  color: Colors.red,
                  icon: logoutIcon,
                  onPressed: () {
                    _authService.signOut();
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: mainBackGroundColor,
      ),
    );
  }
}
