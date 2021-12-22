import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<User?> createStudent(String name, String password, String email,
      String faculty, String studentNo) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("Student").doc(user.user!.uid).set({
      'name': name,
      'email': email,
      'faculty': faculty,
      'studentNo': studentNo,
      'type': "student"
    });
    return user.user;
  }

  Future<User?> createCommunity(
    String name,
    String password,
    String email,
    String faculty,
    String description,
  ) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Community").doc(user.user!.uid).set({
      'name': name,
      'email': email,
      'faculty': faculty,
      'description': description,
      'type': "community",
      'followerNumber': 0,
    });
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }
}