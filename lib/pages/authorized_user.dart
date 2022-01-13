import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/community.dart';

import '../constants.dart';

class AuthorizedUserPage extends StatefulWidget {
  const AuthorizedUserPage({Key? key}) : super(key: key);
  static const String routeName = '/authorized_page';

  @override
  _AuthorizedUserPageState createState() => _AuthorizedUserPageState();
}

class _AuthorizedUserPageState extends State<AuthorizedUserPage> {
  late Community _community;
  final List<Widget> _catalogs = List.of({informationCatalog1, informationCatalog2, informationCatalog3});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(
          backgroundColor: mainBackGroundColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: buildPreferredSize(context, this, true, false, false),
          ),
        ),
        drawer: buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              const Center(
                child: Text(
                  "Welcome to\n\n Student Societies Platform",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20.0),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey, //Colors.greenAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _catalogs[_index % _catalogs.length],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late final Timer timer;

  int _index = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _index++;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
