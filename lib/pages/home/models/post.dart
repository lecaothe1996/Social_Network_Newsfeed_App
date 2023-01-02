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
  String? description;
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

  Post copyWith({
    String? id,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    int? commentCounts,
    List<Images>? images,
    int? likeCounts,
    int? viewCounts,
    int? pulseScore,
    bool? isSensitive,
    bool? isPrivate,
    List? tags,
    User? user,
    List<Post>? photos,
    bool? liked,
    Images? image,
    int? collectionCounts,
    String? pulseType,
    int? storageLength,
  }) =>
      Post(
        id: id ?? this.id,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        description: description ?? this.description,
        commentCounts: commentCounts ?? this.commentCounts,
        images: images ?? this.images,
        likeCounts: likeCounts ?? this.likeCounts,
        viewCounts: viewCounts ?? this.viewCounts,
        pulseScore: pulseScore ?? this.pulseScore,
        isSensitive: isSensitive ?? this.isSensitive,
        isPrivate: isPrivate ?? this.isPrivate,
        tags: tags ?? this.tags,
        user: user ?? this.user,
        photos: photos ?? this.photos,
        liked: liked ?? this.liked,
        image: image ?? this.image,
        collectionCounts: collectionCounts ?? this.collectionCounts,
        pulseType: pulseType ?? this.pulseType,
        storageLength: storageLength ?? this.storageLength,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        title: json["title"],
        description: json["description"],
        commentCounts: json["comment_counts"],
        images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        likeCounts: json["like_counts"],
        viewCounts: json["view_counts"],
        pulseScore: json["pulse_score"],
        isSensitive: json["is_sensitive"],
        isPrivate: json["is_private"],
        tags: json["tags"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        photos: json["photos"] == null ? null : List<Post>.from(json["photos"].map((x) => Post.fromJson(x))),
        liked: json["liked"],
        image: json["image"] == null ? null : Images.fromJson(json["image"]),
        collectionCounts: json["collection_counts"],
        pulseType: json["pulse_type"],
        storageLength: json["storage_length"],
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

  Images copyWith({
    String? id,
    String? url,
    int? orgWidth,
    int? orgHeight,
    String? orgUrl,
    String? dominantColor,
    int? fileSize,
  }) =>
      Images(
        id: id ?? this.id,
        url: url ?? this.url,
        orgWidth: orgWidth ?? this.orgWidth,
        orgHeight: orgHeight ?? this.orgHeight,
        orgUrl: orgUrl ?? this.orgUrl,
        dominantColor: dominantColor ?? this.dominantColor,
        fileSize: fileSize ?? this.fileSize,
      );

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        url: json["url"],
        orgWidth: json["org_width"],
        orgHeight: json["org_height"],
        orgUrl: json["org_url"],
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
  final DateTime? createdAt;

  User copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    Images? avatar,
    String? systemRole,
    bool? isVerified,
    DateTime? createdAt,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
        systemRole: systemRole ?? this.systemRole,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"] == null ? null : Images.fromJson(json["avatar"]),
        systemRole: json["system_role"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );
}
