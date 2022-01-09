import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/community.dart';
import 'package:grad_project/service/crud_service/community_service.dart';

class DetailedCommunityPage extends StatefulWidget {
  final Community community;

  const DetailedCommunityPage({Key? key, required this.community}) : super(key: key);

  @override
  _DetailedCommunityPageState createState() => _DetailedCommunityPageState();
}

class _DetailedCommunityPageState extends State<DetailedCommunityPage> {
  bool _follows = false;

  @override
  void initState() {
    print('id send to this page is: ' + widget.community.id);
    super.initState();
    studentFollowsCommunity(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(backgroundColor: mainBackGroundColor, elevation: 2.0),
        body: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 6.0),
                      child: Image.asset('assets/no_image.png'),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15.0),
                        const Center(
                          child: Text(
                            "Followers",
                            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance.collection('Communities').snapshots(),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text(
                                "",
                                style: TextStyle(fontSize: 35),
                              );
                            }
                            final docs = snapshot.data!.docs;
                            var followers;
                            for (var element in docs) {
                              if (element.id == widget.community.id) {
                                followers = element.data()['followerNumber'];
                              }
                            }
                            return Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                                      child: Text(followers.toString(), style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                            );
                          },
                        ),
                        /*Text(,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)*/
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
                          child: CustomTextButton(
                              text: _follows ? "UNFOLLOW" : "FOLLOW",
                              onPressed: () {
                                setState(() {
                                  CommunityService().updateFollowers(widget.community, FirebaseAuth.instance.currentUser!.uid, _follows);
                                  _follows = !_follows;
                                });
                              },
                              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Descriptive Tags", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.community.description,
              style: const TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Topluluk Görevlileri", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Görevli pozisyonu : Ad Soyad",
              style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Topluluk İletişim Bilgileri", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const ListTile(
              leading: Icon(
                Icons.facebook,
                size: 40,
              ),
              title: Text(
                "default instagram ",
                style: TextStyle(fontSize: 23, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  studentFollowsCommunity(String userId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Communities").doc(widget.community.id).collection("Followers").doc(userId).get();

    setState(() {
      _follows = doc.exists;
    });
  }
}
