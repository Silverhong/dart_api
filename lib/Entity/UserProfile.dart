class UserProfile {
  String? username;
  String? firstname;
  String? lastname;
  String? position;

  UserProfile({this.username, this.firstname, this.lastname, this.position});

  UserProfile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['position'] = this.position;
    return data;
  }
}
