

class UserModel {
  String name;
  String gender;
  String dob;
  String aadharNumber;
  String panNumber;
  String email;
  String aadharFrontImg;
  String aadharBackImg;
  String panCardImg;
  String createdAt;
  String phoneNumber;
  String uid;
  double downPayment;






  UserModel({
    required this.name,
    required this.gender,
    required this.dob,
    required this.aadharNumber,
    required this.panNumber,
    required this.email,
    required this.aadharFrontImg,
    required this.aadharBackImg,
    required this.panCardImg,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    this.downPayment = 0,




  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      dob: map['Date Of Birth'] ?? '',
      aadharNumber: map['aadharNumber'] ?? '',
      panNumber: map['panNumber'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      aadharFrontImg:map['aadharFrontImg'] ?? '',
      aadharBackImg: map['aadharBackImg'] ?? '',
      panCardImg:map['panCardImg'] ?? '',
      downPayment: (map['downPayment'] ?? 0).toDouble(),



    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "gender": gender,
      "Date Of Birth": dob,
      "aadharNumber":aadharNumber,
      "panNumber":panNumber,
      "email": email,
      "uid": uid,
      "aadharFrontImg":aadharFrontImg,
      "aadharBackImg":aadharBackImg,
      "panCardImg":panCardImg,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "downPayment": downPayment,

    };
  }
}
