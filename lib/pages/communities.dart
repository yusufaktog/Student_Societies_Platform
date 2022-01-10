import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/community.dart';
import 'package:grad_project/pages/detailed_community.dart';

import '../constants.dart';

class AuthorizedCommunityPage extends StatefulWidget {
  static const String routeName = '/authorized_community_page';

  const AuthorizedCommunityPage({Key? key}) : super(key: key);

  @override
  _AuthorizedCommunityPageState createState() => _AuthorizedCommunityPageState();
}

class _AuthorizedCommunityPageState extends State<AuthorizedCommunityPage> {
  String _type = 'default';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(
          backgroundColor: mainBackGroundColor,
          bottom: PreferredSize(
            child: Column(
              children: [
                buildPreferredSize(context, this, false, true, false),
                TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search Community',
                    hintStyle: const TextStyle(
                      color: Color(0xFFA0A0A0),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
              ],
            ),
            preferredSize: const Size.fromHeight(69.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Communities").snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState != ConnectionState.waiting
                        ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              var communities = snapshot.data!.docs;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailedCommunityPage(
                                          community: Community(
                                              relatedFaculty: communities[index]["faculty"],
                                              description: communities[index]["description"],
                                              followerNumber: communities[index]["followerNumber"],
                                              communityName: communities[index]["name"],
                                              email: communities[index]["email"],
                                              id: communities[index]["id"]),
                                        ),
                                      ),
                                    );
                                  },
                                  child: FirebaseAuth.instance.currentUser!.uid != communities[index]["id"]
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                                          child: CommunityCard(
                                            community: Community(
                                                relatedFaculty: communities[index]["faculty"],
                                                description: communities[index]["description"],
                                                followerNumber: communities[index]["followerNumber"],
                                                communityName: communities[index]["name"],
                                                email: communities[index]["email"],
                                                id: communities[index]["id"]),
                                          ),
                                        )
                                      : SizedBox(),
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

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  getUserType() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Communities").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      _type = documentSnapshot.exists ? "community" : "student";
    });
  }
}
