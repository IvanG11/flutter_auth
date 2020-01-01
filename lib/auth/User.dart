class User {
  int id;
  String name;
  String email;
  String avatar;

  User({this.id, this.name, this.email, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        avatar: json['avatar']);
  }
}
