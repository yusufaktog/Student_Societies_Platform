import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/pages/activities.dart';
import 'package:grad_project/pages/authorized_community.dart';
import 'package:grad_project/pages/authorized_user.dart';
import 'package:grad_project/pages/communities.dart';
import 'package:grad_project/pages/community_registration_page.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/student_registration_page.dart';

const Color mainBackGroundColor = Color(0xff4D4365);
var routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  StudentRegistration.routeName: (context) => const StudentRegistration(),
  CommunityRegistration.routeName: (context) => const CommunityRegistration(),
  AuthorizedUserPage.routeName: (context) => const AuthorizedUserPage(
        user: null,
      ),
  AuthorizedCommunityPage.routeName: (context) =>
      const AuthorizedCommunityPage(),
  CommunitiesPage.routeName: (context) => const CommunitiesPage(),
  ActivitiesPage.routeName: (context) => const ActivitiesPage(),
};
const preferredAppBarHeight = Size.fromHeight(100);
const Icon logoutIcon = Icon(
  IconData(0xf88b, fontFamily: 'MaterialIcons'),
  color: Colors.red,
);

FirebaseOptions firebaseConfig = const FirebaseOptions(
  apiKey: "AIzaSyB7Qu7D75-FyzGmyu5fnh6Fg_2WD9hopcA",
  authDomain: "graduation-project-ef9a7.firebaseapp.com",
  projectId: "graduation-project-ef9a7",
  storageBucket: "graduation-project-ef9a7.appspot.com",
  messagingSenderId: "228608292447",
  appId: "1:228608292447:web:0fba8a4f254b34fae18dea",
);
