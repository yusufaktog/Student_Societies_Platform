import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/community.dart';

import '../constants.dart';

class AuthorizedCommunityPage extends StatefulWidget {
  static const String routeName = '/authorized_community_page';
  final String type;
  const AuthorizedCommunityPage({Key? key, required this.type})
      : super(key: key);

  @override
  _AuthorizedCommunityPageState createState() =>
      _AuthorizedCommunityPageState();
}

class _AuthorizedCommunityPageState extends State<AuthorizedCommunityPage> {
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
                buildPreferredSize(
                    context, this, true, false, false, widget.type),
                TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Search Community',
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
              ],
            ),
            preferredSize: const Size.fromHeight(69.0),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: InkWell(
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
                                        communityName: communities[index]
                                            ["name"],
                                        email: communities[index]["email"],
                                      ),
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
}
