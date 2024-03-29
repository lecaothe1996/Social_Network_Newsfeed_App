class PostComment {
  PostComment({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.replyForId,
    this.user,
    this.image,
    this.liked,
    this.replyComments,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  String? content;
  final dynamic replyForId;
  final User? user;
  final ImageComment? image;
  final bool? liked;
  final dynamic replyComments;

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
    id: json["id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    content: json["content"],
    replyForId: json["reply_for_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    image: json["image"] == null ? null : ImageComment.fromJson(json["image"]),
    liked: json["liked"],
    replyComments: json["reply_comments"],
  );
}

class ImageComment {
  ImageComment({
    this.url,
    this.orgWidth,
    this.orgHeight,
    this.orgUrl,
    this.cloudName,
    this.dominantColor,
    this.fileSize,
  });

  final String? url;
  final int? orgWidth;
  final int? orgHeight;
  final String? orgUrl;
  final String? cloudName;
  final String? dominantColor;
  final int? fileSize;

  factory ImageComment.fromJson(Map<String, dynamic> json) => ImageComment(
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
  final Avatar? avatar;
  final String? systemRole;
  final bool? isVerified;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    systemRole: json["system_role"],
    isVerified: json["is_verified"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );
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
}