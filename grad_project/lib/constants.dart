import 'dart:ui';

import 'package:grad_project/pages/comunity_registration_page.dart';
import 'package:grad_project/pages/main_page.dart';
import 'package:grad_project/pages/student_registeration_page.dart';

Color mainBackGroundColor = const Color(0xff4D4365);
var routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  StudentRegistration.routeName: (context) => const StudentRegistration(),
  CommunityRegistration.routeName: (context) => const CommunityRegistration()
};
