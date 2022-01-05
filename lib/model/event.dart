import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityEvent {
  String? name;
  String? description;
  String? location;
  Timestamp? time;
  int? participants;
  String? sections;
  String? imageUrl;

  CommunityEvent(this.name, this.description, this.location, this.time,
      this.participants, this.sections, this.imageUrl);
}
