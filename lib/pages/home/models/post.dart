class Post {
  Post({
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
    this.isSensitive,
    this.isPrivate,
    this.tags,
    this.user,
    this.photos,
    this.liked,
    this.image,
    this.collectionCounts,
    this.pulseType,
    this.storageLength,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? title;
  final String? description;
  int? commentCounts;
  final List<Images>? images;
  int? likeCounts;
  final int? viewCounts;
  final int? pulseScore;
  final bool? isSensitive;
  final bool? isPrivate;
  final List? tags;
  final User? user;
  final List<Post>? photos;
  bool? liked;
  final Images? image;
  final int? collectionCounts;
  final String? pulseType;
  final int? storageLength;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    commentCounts: json["comment_counts"] == null ? null : json["comment_counts"],
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    likeCounts: json["like_counts"] == null ? null : json["like_counts"],
    viewCounts: json["view_counts"] == null ? null : json["view_counts"],
    pulseScore: json["pulse_score"] == null ? null : json["pulse_score"],
    isSensitive: json["is_sensitive"] == null ? null : json["is_sensitive"],
    isPrivate: json["is_private"] == null ? null : json["is_private"],
    tags: json["tags"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    photos: json["photos"] == null ? null : List<Post>.from(json["photos"].map((x) => Post.fromJson(x))),
    liked: json["liked"] == null ? null : json["liked"],
    image: json["image"] == null ? null : Images.fromJson(json["image"]),
    collectionCounts: json["collection_counts"] == null ? null : json["collection_counts"],
    pulseType: json["pulse_type"] == null ? null : json["pulse_type"],
    storageLength: json["storage_length"] == null ? null : json["storage_length"],
  );
}

class Images {
  Images({
    this.id,
    this.url,
    this.orgWidth,
    this.orgHeight,
    this.orgUrl,
    this.dominantColor,
    this.fileSize,
  });

  final String? id;
  final String? url;
  final int? orgWidth;
  final int? orgHeight;
  final String? orgUrl;
  final String? dominantColor;
  final int? fileSize;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    orgWidth: json["org_width"] == null ? null : json["org_width"],
    orgHeight: json["org_height"] == null ? null : json["org_height"],
    orgUrl: json["org_url"] == null ? null : json["org_url"],
    dominantColor: json["dominant_color"] == null ? null : json["dominant_color"],
    fileSize: json["file_size"] == null ? null : json["file_size"],
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
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    avatar: json["avatar"] == null ? null : Images.fromJson(json["avatar"]),
    systemRole: json["system_role"] == null ? null : json["system_role"],
    isVerified: json["is_verified"] == null ? null : json["is_verified"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );
}




// class Post {
//   Post({
//     this.id,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.title,
//     this.description,
//     this.commentCounts,
//     this.images,
//     this.likeCounts,
//     this.viewCounts,
//     this.pulseScore,
//     this.tags,
//     this.user,
//     this.liked,
//   });
//
//   final String? id;
//   final int? status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? title;
//   final String? description;
//   final int? commentCounts;
//   final List<Photo>? images;
//   final int? likeCounts;
//   final int? viewCounts;
//   final int? pulseScore;
//   final List? tags;
//   final User? user;
//   final bool? liked;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     id: json["id"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     title: json["title"],
//     description: json["description"],
//     commentCounts: json["comment_counts"],
//     images: json["images"] == null ? null : List<Photo>.from(json["images"].map((x) => Photo.fromJson(x))),
//     likeCounts: json["like_counts"],
//     viewCounts: json["view_counts"],
//     pulseScore: json["pulse_score"],
//     tags: json["tags"],
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//     liked: json["liked"],
//   );
// }
//
// class Photo {
//   Photo({
//     this.id,
//     this.url,
//     this.orgWidth,
//     this.orgHeight,
//     this.orgUrl,
//     this.cloudName,
//     this.dominantColor,
//     this.fileSize,
//   });
//
//   final String? id;
//   final String? url;
//   final int? orgWidth;
//   final int? orgHeight;
//   final String? orgUrl;
//   final String? cloudName;
//   final String? dominantColor;
//   final int? fileSize;
//
//   factory Photo.fromJson(Map<String, dynamic> json) => Photo(
//     id: json["id"],
//     url: json["url"],
//     orgWidth: json["org_width"],
//     orgHeight: json["org_height"],
//     orgUrl: json["org_url"],
//     cloudName: json["cloud_name"],
//     dominantColor: json["dominant_color"],
//     fileSize: json["file_size"],
//   );
// }
//
// class User {
//   User({
//     this.id,
//     this.username,
//     this.firstName,
//     this.lastName,
//     this.avatar,
//     this.systemRole,
//     this.isVerified,
//     this.createdAt,
//   });
//
//   final String? id;
//   final String? username;
//   final String? firstName;
//   final String? lastName;
//   final Photo? avatar;
//   final String? systemRole;
//   final bool? isVerified;
//   final DateTime? createdAt;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     username: json["username"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     avatar: json["avatar"] == null ? null : Photo.fromJson(json["avatar"]),
//     systemRole: json["system_role"],
//     isVerified: json["is_verified"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//   );
// }
