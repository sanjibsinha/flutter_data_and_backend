class User {
  final int? id;
  final String name;

  User({
    this.id,
    required this.name,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

List<User> users = [
  User(name: "Mana"),
  User(name: "Babu"),
  User(name: "Pata"),
  User(name: "Gopal"),
];
