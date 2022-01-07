import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/model/community.dart';
import 'package:grad_project/service/crud_service/community_service.dart';

class DetailedCommunityPage extends StatefulWidget {
  final Community community;

  const DetailedCommunityPage({Key? key, required this.community})
      : super(key: key);

  @override
  _DetailedCommunityPageState createState() => _DetailedCommunityPageState();
}

class _DetailedCommunityPageState extends State<DetailedCommunityPage> {
  String _communityId = '';

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
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 6.0),
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
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('Communities')
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text(
                                "asdasd",
                                style: TextStyle(fontSize: 35),
                              );
                            }
                            final docs = snapshot.data!.docs;
                            var followers;
                            docs.forEach((element) {
                              if (element.data()["email"] ==
                                  widget.community.email) {
                                _communityId = element.id;
                                followers = element.data()['followerNumber'];
                              }
                            });
                            return Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 20.0),
                                      child: Text(followers.toString(),
                                          style: const TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.community.followerNumber =
                                  widget.community.followerNumber + 1;
                              CommunityService().updateFollowers(
                                  widget.community, _communityId);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 24.0),
                              child: Text("FOLLOW",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Descriptive Tags",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.community.description,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start,
            ),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Topluluk Görevlileri",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Görevli pozisyonu : Ad Soyad",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black, thickness: 2),
            const Center(
              child: Text("Topluluk İletişim Bilgileri",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            const ListTile(
              leading: Icon(
                Icons.facebook,
                size: 40,
              ),
              title: Text(
                "default instagram ",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
