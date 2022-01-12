import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grad_project/pages/authorized_user.dart';
import 'package:grad_project/pages/communities.dart';
import 'package:grad_project/pages/community_registration_page.dart';
import 'package:grad_project/pages/events.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/student_registration_page.dart';

const Color mainBackGroundColor = Color(0xff4D4365);
var routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  StudentRegistration.routeName: (context) => const StudentRegistration(),
  CommunityRegistration.routeName: (context) => const CommunityRegistration(),
  AuthorizedUserPage.routeName: (context) => const AuthorizedUserPage(user: null),
  AuthorizedCommunityPage.routeName: (context) => const AuthorizedCommunityPage(),
  EventsPage.routeName: (context) => const EventsPage(),
};
const preferredAppBarHeight = Size.fromHeight(100);
const Icon logoutIcon = Icon(
  IconData(0xf88b, fontFamily: 'MaterialIcons'),
  color: Colors.red,
);
const searchIcon = Icon(Icons.search);

OutlineInputBorder searchBarBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(10.0));
const fillColor = Color(0xFFF0F0F6);
const divider = Divider(color: Colors.black, thickness: 2);

const FirebaseOptions firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyB7Qu7D75-FyzGmyu5fnh6Fg_2WD9hopcA",
  authDomain: "graduation-project-ef9a7.firebaseapp.com",
  projectId: "graduation-project-ef9a7",
  storageBucket: "graduation-project-ef9a7.appspot.com",
  messagingSenderId: "228608292447",
  appId: "1:228608292447:web:0fba8a4f254b34fae18dea",
);
Widget informationCatalog1 = Column(
  children: [
    Image.asset("assets/images/communities.png"),
    const SizedBox(height: 30),
    Text(
      "Communities registered to the app can be viewed from Community tap ",
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
      key: UniqueKey(),
    )
  ],
);
Widget informationCatalog2 = Column(
  children: [
    Image.asset("assets/images/events.PNG"),
    const SizedBox(height: 30),
    Text(
      "All the events created by communities can be viewed from the Events tap",
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
      key: UniqueKey(),
    )
  ],
);
Widget informationCatalog3 = Column(
  children: [
    Image.asset("assets/images/createEvent.png"),
    const SizedBox(height: 30),
    Text(
      "Community Account owners can create Events by using clicking on this button",
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
      key: UniqueKey(),
    )
  ],
);
