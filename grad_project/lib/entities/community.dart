class Community {
  String userName;
  String communityName;
  String relatedFaculty;
  String description;
  int followerNumber;

  Community(
      {required this.communityName,
      required this.description,
      required this.relatedFaculty,
      required this.userName,
      required this.followerNumber});
}
