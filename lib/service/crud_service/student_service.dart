import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/model/student.dart';

class StudentService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createStudent(Student student, String password) async {
    await _auth.createUserWithEmailAndPassword(email: student.email, password: password);
    await _firestore
        .collection("Students")
        .doc(_auth.currentUser!.uid)
        .set({'name': student.name, 'email': student.email, 'faculty': student.faculty, 'studentNo': student.studentNo, 'type': "student"});
  }
}
