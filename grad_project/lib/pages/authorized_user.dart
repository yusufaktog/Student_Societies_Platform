import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/activities.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';
import 'communities.dart';

class AuthorizedUserPage extends StatefulWidget {
  final User? user;

  const AuthorizedUserPage({Key? key, required this.user}) : super(key: key);
  static const String routeName = '/authorized_page';

  @override
  _AuthorizedUserPageState createState() => _AuthorizedUserPageState();
}

class _AuthorizedUserPageState extends State<AuthorizedUserPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var flexFactor = 5;

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
                isUnderlined: true,
                text: "HOME PAGE",
                fontSize: 18,
              ),
            ),
            Expanded(
              flex: flexFactor,
              child: CustomAppBarElement(
                state: this,
                routeName: CommunitiesPage.routeName,
                isUnderlined: false,
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Student').snapshots(),
          builder: (_, snapshot) {
            final docs = snapshot.data!.docs;
            final data = docs[1].data();
            return data['type'];
          },
        ),
      ),
    );
  }
}
