class SignUp {
  String businessName;
  String address;
  String phoneNumber;
  String contactPerson;
  String email;
  int reach;
  String username;
  String password;

  SignUp({
    required this.businessName,
    required this.address,
    required this.phoneNumber,
    required this.contactPerson,
    required this.email,
    required this.reach,
    required this.username,
    required this.password,
  });

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      businessName: json['business_name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      contactPerson: json['contact_person'],
      email: json['email'],
      reach: json['reach'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'address': address,
      'phone_number': phoneNumber,
      'contact_person': contactPerson,
      'email': email,
      'reach': reach,
      'username': username,
      'password': password,
    };
  }
}
