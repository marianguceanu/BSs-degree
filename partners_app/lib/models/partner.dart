class Partner {
  int id;
  String businessName;
  String address;
  String phoneNumber;
  String contactPerson;
  String email;
  int reach;

  Partner(
      {required this.id,
      required this.businessName,
      required this.address,
      required this.phoneNumber,
      required this.contactPerson,
      required this.email,
      required this.reach});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['partner_id'],
      businessName: json['business_name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      contactPerson: json['contact_person'],
      email: json['email'],
      reach: json['reach'],
    );
  }
}
