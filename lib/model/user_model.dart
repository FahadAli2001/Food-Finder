class UserModel {
  final String? fname;
  final String? lname;
  final String? email;
  final String? uid;
  final String? profileImage;
  final String? phone;
  final String? city;

  UserModel(
      {this.fname,
      this.lname,
      this.email,
      this.uid,
      this.profileImage,
      this.city,
      this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fname: json['fname'],
        lname: json['lname'],
        email: json['email'],
        uid: json['uid'],
        profileImage: json['profileImage'],
        phone: json['phone'],
        city: json['city']);
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'uid': uid,
      'profileImage': profileImage,
      'city': city,
      'phone': phone
    };
  }
}
