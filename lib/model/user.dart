class User {
  final int userId;
  final String name;
  final String email;
  bool selected;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.selected});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['id'],
        name: json['name'],
        email: json['email'],
        selected: false);
  }
}

class UserList {
  final List<dynamic> users;

  const UserList({
    required this.users,
  });

  factory UserList.fromJson(List<dynamic> json) {
    var list = [];
    for (var element in json) {
      var u = User(
          userId: element['id'],
          name: element['name'],
          email: element['email'],
          selected: false);
      list.add(u);
    }
    return UserList(users: list);
  }
}
