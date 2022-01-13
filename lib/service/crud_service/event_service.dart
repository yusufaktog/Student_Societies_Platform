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
      'communityId': _auth.currentUser!.uid,
    });
  }

  Future<void> updateParticipants(CommunityEvent event, bool joins) async {
    var _eventId = event.communityId! + event.time!.split('.')[0];
    var document = _firestore.collection("Events").doc(_eventId);

    await document.get().then((value) {
      if (!joins) {
        document.collection("Participants").get().then((value) {
          document.update({'participants': value.size});
        });
        join(_eventId);
      } else {
        document.collection("Participants").doc(_eventId).delete();
        document.collection("Participants").get().then((value) {
          document.update({'participants': value.size});
        });
        unJoin(_eventId);
      }
    });
  }

  join(String eventId) async {
    await _firestore
        .collection("Events")
        .doc(eventId)
        .collection("Participants")
        .doc(_auth.currentUser!.uid)
        .set({'id': _auth.currentUser!.uid, 'email': _auth.currentUser!.email});
  }

  unJoin(String eventId) async {
    await _firestore.collection("Events").doc(eventId).collection("Participants").doc(_auth.currentUser!.uid).delete();
  }
}
