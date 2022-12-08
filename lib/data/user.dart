import "dart:convert";

class User {
  User(
      {required this.id,
      required this.name,
      required this.ra,
      required this.email,
      required this.campus,
      this.senha = ""});

  factory User.fromMap(Map<String, dynamic> map) => User(
      name: map["fullName"],
      ra: map["ra"],
      email: map["email"],
      campus: map["campus"],
      id: map["id"],
      senha: map["password"] ?? "");

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String name;
  String ra;
  String email;
  String campus;
  int id;
  String senha;

  Map<String, dynamic> toMap() =>
      {"name": name, "ra": ra, "email": email, "campus": campus, "id": id};

  String toJson() => json.encode(toMap());
}
