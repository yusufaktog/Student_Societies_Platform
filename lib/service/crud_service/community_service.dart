import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/model/community.dart';

class CommunityService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCommunity(Community community, String password) async {
    await _auth.createUserWithEmailAndPassword(email: community.email, password: password);

    await _firestore.collection("Communities").doc(_auth.currentUser!.uid).set({
      'name': community.communityName,
      'email': community.email,
      'faculty': community.relatedFaculty,
      'description': community.description,
      'followerNumber': 0,
      'type': "community",
      'id': _auth.currentUser!.uid
    });
  }

  Future<void> updateFollowers(Community community, String userId, bool follows) async {
    var document = _firestore.collection("Communities").doc(community.id);
    await document.get().then((value) {
      if (!follows) {
        document.collection("Followers").get().then((value) {
          document.update({'followerNumber': value.size});
        });
        follow(community.id, userId);
      } else {
        document.collection("Followers").doc(userId).delete();
        document.collection("Followers").get().then((value) {
          document.update({'followerNumber': value.size});
        });
        unFollow(community.id, userId);
      }
    });

    print('followers updated');
  }

  follow(String communityId, String userId) async {
    await _firestore
        .collection("Communities")
        .doc(communityId)
        .collection("Followers")
        .doc(userId)
        .set({'email': _auth.currentUser!.email, 'id': _auth.currentUser!.uid});
  }

  unFollow(String communityId, String userId) async {
    await _firestore.collection("Communities").doc(communityId).collection("Followers").doc(userId).delete();
  }

/*
  *     document.get().then((document) {
      print(document.id);
    });
    * */

}
