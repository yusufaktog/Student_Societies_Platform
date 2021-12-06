import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';

import '../constants.dart';
import 'activities.dart';
import 'authorized_user.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({Key? key}) : super(key: key);
  static const String routeName = '/communities';

  @override
  _CommunitiesPageState createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
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
                isUnderlined: true,
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
