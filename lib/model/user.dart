class User {
  final int? id;
  final String name;
  final String location;

  User({
    this.id,
    required this.name,
    required this.location,
  });

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        location = res["location"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }
}

List<User> users = [
  User(name: "Mana", location: "Nabagram"),
  User(name: "Babu", location: "Nabagram"),
  User(name: "Pata", location: "Nabagram"),
  User(name: "Gopal", location: "Nabagram"),
];
