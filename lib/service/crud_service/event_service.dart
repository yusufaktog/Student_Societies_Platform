import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/model/event.dart';

class EventService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createEvent(String communityUid, CommunityEvent event) async {
    await _firestore.collection("Events").doc(communityUid).set({
      'name': event.name,
      'description': event.description,
      'location': event.location,
      'time': event.time,
      'participants': 0,
      'image_url': event.imageUrl,
      'sections': event.sections,
      'communityId': _auth.currentUser!.uid
    });
  }

  Future<void> updateImageURL(
      String communityUid, String eventUid, String imageUrl) async {
    await _firestore
        .collection("Events")
        .doc(communityUid)
        .update({'image_url': imageUrl});
  }

  Future<void> updateParticipants(CommunityEvent event) async {
    var _communityEventDocId =
        event.communityId! + event.time!.toDate().toString().split('.')[0];

    await _firestore
        .collection("Events")
        .doc(_communityEventDocId)
        .update({'participants': event.participants!});
  }
}
