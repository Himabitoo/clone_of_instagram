
class User{
  final String username;
  final String uid;
  final String photoUrl;
  final String email;
  final String bio;
  final List followers;
  final List following;

  // コンストラクタ
  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.bio,
    required this.following,
    required this.followers,
  });

  Map<String , dynamic> toJson() => {
    "username":username,
    "uid": uid,
    "email":email,
    "photoUrl":photoUrl,
    "bio":bio,
    "following":following,
    "followers":followers,
  };

}