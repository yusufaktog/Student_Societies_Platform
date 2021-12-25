import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/entities/event.dart';

class EventService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createEvent(String uid, CommunityEvent event) async {
    await _firestore.collection("Events").doc(_auth.currentUser!.uid).set({
      'name': event.name,
      'description': event.description,
      'location': event.location,
      'TimeStamp': event.time,
      'participants': 0,
      'image': event.imageFile
    });
  }
}
