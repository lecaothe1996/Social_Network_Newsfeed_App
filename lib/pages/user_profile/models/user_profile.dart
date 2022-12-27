class UserProfile {
  UserProfile({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phonePrefix,
    this.phone,
    this.gender,
    this.dob,
    this.avatar,
    this.totalPoints,
    this.balancePoints,
    this.systemRole,
    this.scores,
    this.isVerified,
    this.counters,
    this.followed,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phonePrefix;
  final String? phone;
  final String? gender;
  final DateTime? dob;
  final Avatar? avatar;
  final int? totalPoints;
  final int? balancePoints;
  final String? systemRole;
  final int? scores;
  final bool? isVerified;
  final Counters? counters;
  final bool? followed;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phonePrefix: json["phone_prefix"],
        phone: json["phone"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
        totalPoints: json["total_points"],
        balancePoints: json["balance_points"],
        systemRole: json["system_role"],
        scores: json["scores"],
        isVerified: json["is_verified"],
        counters: json["counters"] == null ? null : Counters.fromJson(json["counters"]),
        followed: json["followed"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_prefix": phonePrefix,
    "phone": phone,
    "gender": gender,
    "dob": dob == null ? null : "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "avatar": avatar?.toJson(),
    "total_points": totalPoints,
    "balance_points": balancePoints,
    "system_role": systemRole,
    "scores": scores,
    "is_verified": isVerified,
    "counters": counters?.toJson(),
    "followed": followed,
  };
}

class Avatar {
  Avatar({
    this.url,
    this.orgWidth,
    this.orgHeight,
    this.orgUrl,
    this.cloudName,
    this.dominantColor,
  });

  final String? url;
  final int? orgWidth;
  final int? orgHeight;
  final String? orgUrl;
  final String? cloudName;
  final String? dominantColor;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        url: json["url"],
        orgWidth: json["org_width"],
        orgHeight: json["org_height"],
        orgUrl: json["org_url"],
        cloudName: json["cloud_name"],
        dominantColor: json["dominant_color"],
      );

  Map<String, dynamic> toJson() => {
    "url": url,
    "org_width": orgWidth,
    "org_height": orgHeight,
    "org_url": orgUrl,
    "cloud_name": cloudName,
    "dominant_color": dominantColor,
  };
}

class Counters {
  Counters({
    this.photos,
    this.likes,
    this.followers,
    this.followings,
    this.collections,
    this.bookings,
    this.bookingApplications,
  });

  final int? photos;
  final int? likes;
  final int? followers;
  final int? followings;
  final int? collections;
  final int? bookings;
  final int? bookingApplications;

  factory Counters.fromJson(Map<String, dynamic> json) => Counters(
        photos: json["photos"],
        likes: json["likes"],
        followers: json["followers"],
        followings: json["followings"],
        collections: json["collections"],
        bookings: json["bookings"],
        bookingApplications: json["booking_applications"],
      );

  Map<String, dynamic> toJson() => {
    "photos": photos,
    "likes": likes,
    "followers": followers,
    "followings": followings,
    "collections": collections,
    "bookings": bookings,
    "booking_applications": bookingApplications,
  };
}