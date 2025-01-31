class Like {
  final String userId;
  final String profileId;

  Like({required this.userId, required this.profileId});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      userId: json['userId'],
      profileId: json['profileId'],
    );
  }
}
