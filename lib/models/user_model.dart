class UserModel {
  String? uid;
  String? email;
  String? recentlyUsedId;
  String? recentlyUsedLabel;

  UserModel(
      {this.uid, this.email, this.recentlyUsedId, this.recentlyUsedLabel});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        recentlyUsedId: map['recentlyUsedId'],
        recentlyUsedLabel: map['recentlyUsedLabel']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'recentlyUsedId': recentlyUsedId,
      'recentlyUsedLabel': recentlyUsedLabel,
    };
  }
}
