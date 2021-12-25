class Community {
  String? userName;
  String communityName;
  String relatedFaculty;
  String description;
  int followerNumber;
  String email;

  Community(
      {required this.communityName,
      required this.description,
      required this.relatedFaculty,
      this.userName,
      required this.followerNumber,
      required this.email});
}
