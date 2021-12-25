import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/entities/section.dart';
import 'package:image_picker/image_picker.dart';

class CommunityEvent {
  String? name;
  String? description;
  String? location;
  Timestamp? time;
  int? participants;
  List<Section>? sections;
  XFile? imageFile;

  CommunityEvent.detailed(this.name, this.description, this.location, this.time,
      this.participants, this.sections, this.imageFile);

  CommunityEvent.previewed(
      this.name, this.description, this.time, this.imageFile);
}
