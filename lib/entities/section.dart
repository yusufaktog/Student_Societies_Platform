import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  String name;
  Timestamp startTime;
  Timestamp endTime;
  String speaker;

  Section(this.name, this.startTime, this.endTime, this.speaker);
}
