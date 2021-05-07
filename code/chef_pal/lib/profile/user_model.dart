// written by: Shahir
// tested by:
// debugged by:
// User data class

class UserData {
  final String uid;
  String username, diet;
  Map<String, dynamic> intolerences;
  UserData({this.uid, this.username, this.diet, this.intolerences});

  String get userName {
    return this.username;
  }

  String get userDiet {
    return this.diet;
  }

  Map<String, dynamic> get userIntolerences {
    return this.intolerences;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'intolerences': intolerences,
      'diet': diet,
    };
  }
}
