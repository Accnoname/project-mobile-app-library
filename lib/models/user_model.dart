class AppUser {
  final String uid;
  String name;
  String email;
  String photoUrl;
  String birthday;
  String gender;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.birthday,
    required this.gender,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      birthday: map['birthday'] ?? '',
      gender: map['gender'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'birthday': birthday,
      'gender': gender,
    };
  }
}
