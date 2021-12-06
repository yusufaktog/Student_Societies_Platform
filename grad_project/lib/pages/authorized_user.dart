import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/activities.dart';

import '../constants.dart';
import 'communities.dart';

class AuthorizedUserPage extends StatefulWidget {
  const AuthorizedUserPage({Key? key}) : super(key: key);
  static const String routeName = '/user_main_page';

  @override
  _AuthorizedUserPageState createState() => _AuthorizedUserPageState();
}

class _AuthorizedUserPageState extends State<AuthorizedUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredAppBarHeight,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CustomAppBarElement(
                state: this,
                routeName: AuthorizedUserPage.routeName,
                isUnderlined: true,
                text: "HOME PAGE",
                fontSize: 20,
              ),
            ),
            Expanded(
              child: CustomAppBarElement(
                state: this,
                routeName: CommunitiesPage.routeName,
                isUnderlined: false,
                text: "COMMUNITIES",
                fontSize: 20,
              ),
            ),
            Expanded(
              child: CustomAppBarElement(
                state: this,
                routeName: ActivitiesPage.routeName,
                isUnderlined: false,
                text: "ACTIVITIES",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: mainBackGroundColor,
      ),
    );
  }
}
