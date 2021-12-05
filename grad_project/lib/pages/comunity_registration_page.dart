import 'package:flutter/material.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/pages/student_registeration_page.dart';

import '../constants.dart';

void main() {
  runApp(
    MaterialApp(
      home: CommunityRegistration(),
      routes: routes,
    ),
  );
}

class CommunityRegistration extends StatefulWidget {
  static const String routeName = '/community_registration';

  const CommunityRegistration({Key? key}) : super(key: key);

  @override
  _CommunityRegistrationState createState() => _CommunityRegistrationState();
}

class _CommunityRegistrationState extends State<CommunityRegistration> {
  String currentHeader = "community";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackGroundColor,
      appBar: buildRegistrationPageAppBar(context, currentHeader, this),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              "Student Community \n Registration Form",
              style: TextStyle(
                fontSize: 30,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          ),
          CustomCard(
            backGroundColor: mainBackGroundColor,
            borderRadius: 10.0,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Username",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: mainBackGroundColor,
            borderRadius: 10.0,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Password",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: mainBackGroundColor,
            borderRadius: 10.0,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Community Name",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: mainBackGroundColor,
            borderRadius: 10.0,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Faculty (Translete it later!)",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
            backGroundColor: mainBackGroundColor,
            borderRadius: 10.0,
            allPadding: 8.0,
            verticalMargin: 5.0,
            horizontalMargin: 20.0,
            child: const CustomTextField(
              hintText: "Description(Enter a description stating"
                  " that your community has a permission",
              fontSize: 15,
              textColor: Colors.black87,
            ),
          ),
          CustomCard(
              backGroundColor: Colors.grey,
              verticalMargin: 25.0,
              horizontalMargin: 20.0,
              allPadding: 8.0,
              child: CustomTextButton(
                text: "SEND THE FORM",
                onPressed: () {},
                textStyle: const TextStyle(color: Colors.black87),
              ),
              borderRadius: 10.0)
        ],
      ),
    );
  }
}
