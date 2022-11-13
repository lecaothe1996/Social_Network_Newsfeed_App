
import 'dart:ui';

class HomeFeed {
  HomeFeed({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.commentCounts,
    required this.images,
    required this.likeCounts,
    required this.viewCounts,
    required this.pulseScore,
    this.tags,
    required this.user,
    required this.liked,
  });

  final String id;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String description;
  final int commentCounts;
  final List<Images> images;
  final int likeCounts;
  final int viewCounts;
  final int pulseScore;
  final String? tags;
  final User user;
  final bool liked;

  factory HomeFeed.fromJson(Map<String, dynamic> json) => HomeFeed (
    id: json["id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    title: json["title"],
    description: json["description"],
    commentCounts: json["comment_counts"],
    images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    likeCounts: json["like_counts"],
    viewCounts: json["view_counts"],
    pulseScore: json["pulse_score"],
    tags: json["tags"],
    user: User.fromJson(json["user"]),
    liked: json["liked"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "status": status,
  //   "created_at": createdAt.toString(),
  //   "updated_at": updatedAt.toString(),
  //   "title": title,
  //   "description": description,
  //   "comment_counts": commentCounts,
  //   "images": List<dynamic>.from(images.map((x) => x.toJson())),
  //   "like_counts": likeCounts,
  //   "view_counts": viewCounts,
  //   "pulse_score": pulseScore,
  //   "tags": tags,
  //   "user": user.toJson(),
  //   "liked": liked,
  // };
}

class Images {
  Images({
    this.id,
    required this.url,
    required this.orgWidth,
    required this.orgHeight,
    this.orgUrl,
    required this.cloudName,
    this.dominantColor,
    this.fileSize,
  });

  final String? id;
  final String url;
  final int orgWidth;
  final int orgHeight;
  final String? orgUrl;
  final String cloudName;
  final String? dominantColor;
  final int? fileSize;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"],
    url: json["url"],
    orgWidth: json["org_width"],
    orgHeight: json["org_height"],
    orgUrl: json["org_url"],
    cloudName: json["cloud_name"],
    dominantColor: json["dominant_color"],
    fileSize: json["file_size"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "url": url,
  //   "org_width": orgWidth,
  //   "org_height": orgHeight,
  //   "org_url": orgUrl,
  //   "cloud_name": cloudName,
  //   "dominant_color": dominantColor,
  //   "file_size": fileSize,
  // };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.systemRole,
    required this.isVerified,
    required this.createdAt,
  });

  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final Images avatar;
  final String systemRole;
  final bool isVerified;
  final String createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: Images.fromJson(json["avatar"]),
    systemRole: json["system_role"],
    isVerified: json["is_verified"],
    createdAt: json["created_at"],
  );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "username": username,
  //   "first_name": firstName,
  //   "last_name": lastName,
  //   "avatar": avatar.toJson(),
  //   "system_role": systemRole,
  //   "is_verified": isVerified,
  //   "created_at": createdAt.toString(),
  // };
}

class Avatar {
  Avatar({
    required this.url,
    required this.orgWidth,
    required this.orgHeight,
    required this.orgUrl,
    required this.cloudName,
    required this.dominantColor,
  });

  final String url;
  final int orgWidth;
  final int orgHeight;
  final String orgUrl;
  final String cloudName;
  final String dominantColor;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    url: json["url"],
    orgWidth: json["org_width"],
    orgHeight: json["org_height"],
    orgUrl: json["org_url"],
    cloudName: json["cloud_name"],
    dominantColor: json["dominant_color"],
  );

  // Map<String, dynamic> toJson() => {
  //   "url": url,
  //   "org_width": orgWidth,
  //   "org_height": orgHeight,
  //   "org_url": orgUrl,
  //   "cloud_name": cloudName,
  //   "dominant_color": dominantColor,
  // };
}
