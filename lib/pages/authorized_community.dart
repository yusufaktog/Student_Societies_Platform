import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/entities/community.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class AuthorizedCommunityPage extends StatefulWidget {
  static const String routeName = '/authorized_community_page';

  const AuthorizedCommunityPage({Key? key}) : super(key: key);

  @override
  _AuthorizedCommunityPageState createState() =>
      _AuthorizedCommunityPageState();
}

class _AuthorizedCommunityPageState extends State<AuthorizedCommunityPage> {
  final ImagePicker _picker = ImagePicker();

  // Pick an image

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            child: Column(
              children: [
                buildPreferredSize(context, this, false, true, false),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            color: Color(0xFFA0A0A0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F6),
                          focusColor: const Color(0xFFF0F0F6),
                          prefixIcon: IconButton(
                            icon: searchIcon,
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            _displayTextInputDialog(context);
                          },
                          child: Text("Create Event")),
                    )
                  ],
                )
              ],
            ),
            preferredSize: const Size.fromHeight(42.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Communities")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState != ConnectionState.waiting
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              var communities = snapshot.data!.docs;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CommunityCard(
                                        community: Community(
                                          relatedFaculty: communities[index]
                                              ["faculty"],
                                          description: communities[index]
                                              ["description"],
                                          followerNumber: communities[index]
                                              ["followerNumber"],
                                          communityName: communities[index]
                                              ["name"],
                                          email: communities[index]["email"],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 16.0),
                                  child: CommunityCard(
                                    community: Community(
                                      relatedFaculty: communities[index]
                                          ["faculty"],
                                      description: communities[index]
                                          ["description"],
                                      followerNumber: communities[index]
                                          ["followerNumber"],
                                      communityName: communities[index]["name"],
                                      email: communities[index]["email"],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create Event'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: const InputDecoration(hintText: "Event name:"),
                ),
                TextField(
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: const InputDecoration(hintText: "Description:"),
                ),
                TextField(
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: const InputDecoration(hintText: "Location:"),
                ),
                TextField(
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: const InputDecoration(hintText: "Time: "),
                ),
                TextField(
                  maxLines: 2,
                  onChanged: (value) {
                    //setState(() {});
                  },
                  decoration: const InputDecoration(
                      label: Text("Sections:"),
                      hintText: "00:00-01:00-Example Speaker"),
                ),
                Row(
                  children: [
                    TextButton(
                      child: const Text("image from gallery"),
                      onPressed: () async {
                        String eventImageUrl = "";
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        final XFile? photo = await _picker.pickImage(
                            source: ImageSource.gallery);
                        Reference reference = FirebaseStorage.instance
                            .ref()
                            .child("Events")
                            .child(fileName);
                        UploadTask uploadTask =
                            reference.putFile(File(photo!.path));

                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() {});
                        await taskSnapshot.ref.getDownloadURL().then((url) {
                          eventImageUrl = url;
                        });
                        print(eventImageUrl);
                      },
                    ),
                    TextButton(
                      child: const Text("Image from camera"),
                      onPressed: () async {
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);
                      },
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
