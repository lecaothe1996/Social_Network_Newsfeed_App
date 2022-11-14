
class HomeFeed {
  HomeFeed({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.commentCounts,
    this.images,
    this.likeCounts,
    this.viewCounts,
    this.pulseScore,
    this.tags,
    this.user,
    this.liked,
  });

  final String? id;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final String? title;
  final String? description;
  final int? commentCounts;
  final List<Images>? images;
  final int? likeCounts;
  final int? viewCounts;
  final int? pulseScore;
  final List? tags;
  final User? user;
  final bool? liked;

  factory HomeFeed.fromJson(Map<String, dynamic> json) => HomeFeed(
    id: json["id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    title: json["title"],
    description: json["description"],
    commentCounts: json["comment_counts"],
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    likeCounts: json["like_counts"],
    viewCounts: json["view_counts"],
    pulseScore: json["pulse_score"],
    tags: json["tags"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    liked: json["liked"],
  );
}

class Images {
  Images({
    this.id,
    this.url,
    this.orgWidth,
    this.orgHeight,
    this.orgUrl,
    this.cloudName,
    this.dominantColor,
    this.fileSize,
  });

  final String? id;
  final String? url;
  final int? orgWidth;
  final int? orgHeight;
  final String? orgUrl;
  final String? cloudName;
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
}

class User {
  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.avatar,
    this.systemRole,
    this.isVerified,
    this.createdAt,
  });

  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final Images? avatar;
  final String? systemRole;
  final bool? isVerified;
  final String? createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"] == null ? null : Images.fromJson(json["avatar"]),
    systemRole: json["system_role"],
    isVerified: json["is_verified"],
    createdAt: json["created_at"],
  );
}
