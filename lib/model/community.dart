class Community {
  String? userName;
  String communityName;
  String relatedFaculty;
  String description;
  int followerNumber;
  String? imageUrl;
  String email;
  String id;

  Community(
      {required this.communityName,
      required this.description,
      required this.relatedFaculty,
      this.userName,
      required this.followerNumber,
      required this.email,
      required this.id,
      this.imageUrl});
}
