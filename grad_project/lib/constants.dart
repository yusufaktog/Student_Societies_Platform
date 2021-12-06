import 'dart:ui';

import 'package:grad_project/pages/activities.dart';
import 'package:grad_project/pages/authorized_user.dart';
import 'package:grad_project/pages/communities.dart';
import 'package:grad_project/pages/community_registration_page.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/student_registration_page.dart';

Color mainBackGroundColor = const Color(0xff4D4365);
var routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  StudentRegistration.routeName: (context) => const StudentRegistration(),
  CommunityRegistration.routeName: (context) => const CommunityRegistration(),
  AuthorizedUserPage.routeName: (context) => const AuthorizedUserPage(),
  CommunitiesPage.routeName: (context) => const CommunitiesPage(),
  ActivitiesPage.routeName: (context) => const ActivitiesPage(),
};
const preferredAppBarHeight = Size.fromHeight(100);
