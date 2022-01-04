import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/service/auth.dart';

import '../constants.dart';

/*
emaili çek @soc etiketi varsa activity oluştur butonunu göster yoksa gösterme
 */

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);
  static const String routeName = '/activities';

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: buildPreferredSize(context, this, false, false, true),
        body: Container(
          color: mainBackGroundColor,
        ),
      ),
    );
  }
}
