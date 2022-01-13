import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/community.dart';
import 'package:grad_project/service/crud_service/community_service.dart';
import 'package:image_picker/image_picker.dart';

class CommunityAccountSettings extends StatefulWidget {
  static const String routeName = "/settings";

  const CommunityAccountSettings({Key? key}) : super(key: key);

  @override
  _CommunityAccountSettingsState createState() => _CommunityAccountSettingsState();
}

class _CommunityAccountSettingsState extends State<CommunityAccountSettings> {
  late Community _community;
  Widget _image = Image.asset("assets/images/add_photo.png");
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(
          title: const Text("SETTINGS"),
          centerTitle: true,
          elevation: 2.0,
          backgroundColor: mainBackGroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              CustomCard(
                  backGroundColor: mainBackGroundColor,
                  verticalMargin: 4.0,
                  horizontalMargin: 16.0,
                  allPadding: 8.0,
                  child: CustomTextField(
                    hintText: "Description",
                    fontSize: 25,
                    textColor: Colors.black,
                    onChanged: (value) {
                      _community.description = value;
                    },
                  ),
                  borderRadius: 8.0),
              CustomCard(
                  backGroundColor: mainBackGroundColor,
                  verticalMargin: 4.0,
                  horizontalMargin: 16.0,
                  allPadding: 8.0,
                  child: CustomTextField(
                    hintText: "Faculty",
                    fontSize: 25,
                    textColor: Colors.black,
                    onChanged: (value) {
                      _community.relatedFaculty = value;
                    },
                  ),
                  borderRadius: 8.0),
              CustomCard(
                  backGroundColor: mainBackGroundColor,
                  verticalMargin: 4.0,
                  horizontalMargin: 16.0,
                  allPadding: 8.0,
                  child: CustomTextField(
                    hintText: "Name",
                    fontSize: 25,
                    textColor: Colors.black,
                    onChanged: (value) {
                      _community.communityName = value;
                    },
                  ),
                  borderRadius: 8.0),
              CustomCard(
                  backGroundColor: mainBackGroundColor,
                  verticalMargin: 16.0,
                  horizontalMargin: 16.0,
                  allPadding: 10.0,
                  child: IconButton(
                    onPressed: () async {
                      _isActive = false;
                      final ImagePicker _picker = ImagePicker();

                      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                      Reference reference = FirebaseStorage.instance.ref().child("Communities").child(fileName);
                      UploadTask uploadTask = reference.putFile(File(image!.path));

                      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
                      await taskSnapshot.ref.getDownloadURL().then((url) {
                        _community.imageUrl = url;
                        setState(() {
                          _image = Image.network(url);
                        });
                      }).whenComplete(() => _isActive = true);
                    },
                    icon: CircleAvatar(radius: 100, child: _image),
                    iconSize: 100,
                  ),
                  borderRadius: 100.0),
              CustomCard(
                  backGroundColor: Colors.grey,
                  verticalMargin: 40.0,
                  horizontalMargin: 64.0,
                  allPadding: 8.0,
                  child: CustomTextButton(
                    onPressed: () {
                      if (!_isActive) {
                        Fluttertoast.showToast(msg: "Please wait while image is being uploaded");
                        return;
                      }
                      CommunityService()
                          .update(
                            Community(
                                communityName: _community.communityName,
                                description: _community.description,
                                relatedFaculty: _community.relatedFaculty,
                                followerNumber: _community.followerNumber,
                                email: _community.email,
                                id: _community.id,
                                imageUrl: _community.imageUrl),
                          )
                          .whenComplete(() => Navigator.pop(context));
                    },
                    text: 'UPDATE',
                    textStyle: const TextStyle(fontSize: 25, color: Colors.black87),
                  ),
                  borderRadius: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentCommunity();
  }

  getCurrentCommunity() async {
    var doc = await FirebaseFirestore.instance.collection("Communities").doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() {
      _community = Community(
          relatedFaculty: doc.data()!["faculty"],
          followerNumber: doc.data()!["followerNumber"],
          description: doc.data()!["description"],
          communityName: doc.data()!["name"],
          id: doc.data()!["id"],
          email: doc.data()!["email"]);
    });
  }
}
