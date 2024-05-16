class Profile {
  String? user_id;
  String? user_name;
  String? email;
  String? password;

  Profile({this.user_id, this.user_name, this.email, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password
    };
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
