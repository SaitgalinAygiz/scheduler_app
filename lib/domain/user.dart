class User {
  String name;
  String id;

  User({this.name, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['_id']
    );
  }
}