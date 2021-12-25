import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/entities/community.dart';

class CommunityService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCommunity(Community community, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: community.email, password: password);

    await _firestore.collection("Communities").doc(_auth.currentUser!.uid).set({
      'name': community.communityName,
      'email': community.email,
      'faculty': community.relatedFaculty,
      'description': community.description,
      'followerNumber': 0,
      'type': "community",
    });
  }
}
