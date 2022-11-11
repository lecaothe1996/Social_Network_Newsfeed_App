import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.accessToken,
    this.refreshToken,
    this.oauthId,
    this.expiresIn,
    this.isNew,
    this.hasUsernamePassword,
  });
  String? accessToken;
  String? refreshToken;
  String? oauthId;
  int? expiresIn;
  bool? isNew;
  bool? hasUsernamePassword;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    oauthId: json["oauth_id"],
    expiresIn: json["expires_in"],
    isNew: json["is_new"],
    hasUsernamePassword: json["has_username_password"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "oauth_id": oauthId,
    "expires_in": expiresIn,
    "is_new": isNew,
    "has_username_password": hasUsernamePassword,
  };
}