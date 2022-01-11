import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:grad_project/customized_builders/custom_builder.dart';
import 'package:grad_project/model/event.dart';
import 'package:grad_project/service/crud_service/event_service.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import 'detailed_event.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  static const String routeName = '/activities';

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ImagePicker _picker = ImagePicker();
  final EventService _eventService = EventService();
  final user = FirebaseAuth.instance.currentUser;

  String _type = "default";

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainBackGroundColor,
        appBar: AppBar(
          backgroundColor: mainBackGroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(adjustPreferredHeight()),
            child: Column(
              children: [buildPreferredSize(context, this, false, false, true), buildCreateEventButton()],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Events").snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState != ConnectionState.waiting
                        ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              var events = snapshot.data!.docs;
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailedEventCard(
                                          event: CommunityEvent(
                                              events[index]["name"],
                                              events[index]["description"],
                                              events[index]["location"],
                                              events[index]["time"],
                                              events[index]["participants"],
                                              events[index]["sections"],
                                              events[index]["image_url"],
                                              events[index]["communityId"])),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                                  child: EventCard(
                                      event: CommunityEvent(
                                          events[index]["name"],
                                          events[index]["description"],
                                          events[index]["location"],
                                          events[index]["time"],
                                          events[index]["participants"],
                                          events[index]["sections"],
                                          events[index]["image_url"],
                                          events[index]["communityId"])),
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
    var _name = '';
    var _description = '';
    var _location = '';
    DateTime? _time = DateTime.now();
    var _sections = '';
    String? _imageUrl;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create Event'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    textInputAction: TextInputAction.newline,
                    onChanged: (value) {
                      _name = value;
                    },
                    decoration: const InputDecoration(hintText: "Event name:"),
                  ),
                  TextField(
                    onChanged: (value) {
                      _description = value;
                    },
                    decoration: const InputDecoration(hintText: "Description:"),
                  ),
                  TextField(
                    onChanged: (value) {
                      _location = value;
                    },
                    decoration: const InputDecoration(hintText: "Location:"),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Tİme: ${_time.toString().split('.'[0])}"),
                    readOnly: true,
                    autofocus: false,
                    enabled: false,
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime.now().add(const Duration(days: 90, hours: 24)), onChanged: (date) {
                        setState(() {
                          _time = date;
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          _time = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en, theme: const DatePickerTheme(headerColor: Colors.red));
                    },
                    child: const Center(
                      child: Text(
                        'Show Date Time Picker',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  TextField(
                    maxLines: 2,
                    onChanged: (value) {
                      _sections = value;
                    },
                    decoration: const InputDecoration(label: Text("Sections:"), hintText: "00:00-01:00-Example Speaker"),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text("image from gallery"),
                        onPressed: () async {
                          String timeStr = _time.toString().split('.')[0];

                          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                          Reference reference = FirebaseStorage.instance.ref().child("Events").child(fileName);
                          UploadTask uploadTask = reference.putFile(File(image!.path));

                          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
                          await taskSnapshot.ref.getDownloadURL().then((url) {
                            _imageUrl = url;
                            _eventService.updateImageURL(user!.uid + timeStr, _name, _imageUrl!);
                          });
                        },
                      ),
                      TextButton(
                        child: const Text("Image from camera"),
                        onPressed: () async {
                          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                          String timeStr = _time.toString().split('.')[0];
                          final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                          Reference reference = FirebaseStorage.instance.ref().child("Events").child(fileName);
                          UploadTask uploadTask = reference.putFile(File(photo!.path));

                          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
                          await taskSnapshot.ref.getDownloadURL().then((url) {
                            _imageUrl = url;
                            _eventService.updateImageURL(user!.uid + timeStr, _name, _imageUrl!);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  String timeStr = _time.toString().split('.')[0]; // toUtc() ?
                  CommunityEvent event = CommunityEvent(_name, _description, _location, Timestamp.fromDate(DateTime.parse(timeStr)), 0, _sections,
                      _imageUrl, FirebaseAuth.instance.currentUser!.uid);
                  await _eventService.createEvent(user!.uid + timeStr, event);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  buildCreateEventButton() {
    if (_type == "community") {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {
                _displayTextInputDialog(context);
              },
              child: const Text("Create Event"),
            ),
          )
        ],
      );
    }
    return const SizedBox();
  }

  adjustPreferredHeight() {
    if (_type == "community") {
      return 58.0;
    } else {
      return 20.0;
    }
  }

  getUserType() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Communities").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      _type = documentSnapshot.exists ? "community" : "student";
    });
  }
}
