import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/model/event.dart';
import 'package:grad_project/service/crud_service/event_service.dart';

class DetailedEventCard extends StatefulWidget {
  final CommunityEvent event;

  const DetailedEventCard({Key? key, required this.event}) : super(key: key);

  @override
  _DetailedEventCardState createState() => _DetailedEventCardState();
}

class _DetailedEventCardState extends State<DetailedEventCard> {
  bool _joins = false;

  @override
  void initState() {
    super.initState();
    studentJoinsEvent(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(title: Text(widget.event.name!), centerTitle: true, backgroundColor: mainBackGroundColor, elevation: 2.0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(widget.event.imageUrl!),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0, top: 8.0, bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                                child: Text(
                                  "Participants",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance.collection('Events').snapshots(),
                            builder: (_, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              final docs = snapshot.data!.docs;
                              var participants = 0;
                              for (var element in docs) {
                                if (element.id == widget.event.communityId! + widget.event.time!.split('.')[0]) {
                                  participants = element.data()['participants'];
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
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      child: Text(participants.toString(), style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    EventService().updateParticipants(widget.event, _joins);
                                    _joins = !_joins;
                                  });
                                },
                                child: Text(
                                  _joins ? "UNJOIN" : "JOIN",
                                  style: const TextStyle(fontSize: 25.0),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on,
                  size: 40,
                ),
                title: Text(
                  widget.event.location ?? "default location",
                  style: const TextStyle(fontSize: 23, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.date_range,
                  size: 40,
                ),
                title: Text(
                  widget.event.time!.replaceAll('-', '/').split('.')[0],
                  style: const TextStyle(fontSize: 23, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(thickness: 2.0, color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListTile(
                  title: const Center(
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 23, color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.event.description!, style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 2.0, color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ListTile(
                  title: const Center(
                    child: Text(
                      "Sections",
                      style: TextStyle(fontSize: 23, color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.event.sections!,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  studentJoinsEvent(String userId) async {
    var eventId = widget.event.communityId! + widget.event.time!.split('.')[0];
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Events").doc(eventId).collection("Participants").doc(userId).get();

    setState(() {
      _joins = doc.exists;
    });
  }
}
