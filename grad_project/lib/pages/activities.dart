import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';

import '../constants.dart';
import 'authorized_user.dart';
import 'communities.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);
  static const String routeName = '/activities';

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
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
                isUnderlined: false,
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
                isUnderlined: true,
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
