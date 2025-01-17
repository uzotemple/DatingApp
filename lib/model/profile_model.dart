class Profile {
  final String? profileId;
  final String? nickname;
  final String? age;
  final String? location;
  final String? imageUrl;
  final String? gender;
  final String? relationshipGoals;
  final String? weight;
  final String? height;
  final String? country;
  final String? city;
  final String? bio;
  final String? interest;
  final String? educationLevel;
  final String? profession;
  Profile(
      {this.profileId,
      this.nickname,
      this.age,
      this.location,
      this.imageUrl,
      this.gender,
      this.relationshipGoals,
      this.weight,
      this.height,
      this.country,
      this.city,
      this.bio,
      this.interest,
      this.educationLevel,
      this.profession});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileId: json["profileId"],
      nickname: json["nickname"] ?? "Unknown",
      age: json["age"]?.toString() ?? "N/A",
      location: json["location"] ?? "Unknown",
      gender: json["gender"] ?? "Unknown",
      relationshipGoals: json["relationshipGoals"] ?? "Unknown",
      weight: json["weight"]?.toString() ?? "N/A",
      height: json["height"]?.toString() ?? "N/A",
      country: json["country"] ?? "Unknown",
      city: json["city"] ?? "Unknown",
      profession: json["profession"] ?? "Unknown",
      bio: json["bio"] ?? "Unknown",
      interest: json["interest"] ?? "Unknown",
      educationLevel: json["educationLevel"] ?? "Unknown",

      // imageUrl: json["imageLinks"] != null && json["imageLinks"].isNotEmpty
      //     ? json["imageLinks"][0]["link"]
      //     : "https://images.app.goo.gl/8uuuE3yai5khHPjZA",
      imageUrl: "https://images.app.goo.gl/8uuuE3yai5khHPjZA",
    );
  }
}
