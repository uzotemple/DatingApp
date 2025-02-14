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
  final bool? pics;
  final String? religion;
  final String? sexuality;
  final String? smoking;
  final String? drinking;
  final String? pets;
  final String? children;
  final String? personality;
  final String? relationshipStatus;
  final String? starSign;
  final String? language;
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
      this.profession,
      this.pics,
      this.drinking,
      this.pets,
      this.religion,
      this.sexuality,
      this.smoking,
      this.children,
      this.language,
      this.personality,
      this.relationshipStatus,
      this.starSign
      });

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
      religion: json['religion'] ?? "",
      sexuality: json['sexuality'] ?? "",
      smoking: json['smoking'] ?? "",
      drinking: json['drinking'] ?? "",
      pets: json['pets'] ?? "",
      children: json['children'] ?? "",
      personality: json['personality'] ?? "",
      relationshipStatus: json['relationshipStatus'] ?? "",
      starSign: json['starSign'] ?? "",
      language: json['language'] ?? "",

      // imageUrl: json["imageLinks"] != null && json["imageLinks"].isNotEmpty
      //     ? json["imageLinks"][0]["link"]
      //     : "https://images.app.goo.gl/8uuuE3yai5khHPjZA",
      imageUrl: "https://images.app.goo.gl/8uuuE3yai5khHPjZA",
      pics: json['isPicsVerified'] ?? false,
    );
  }
}
