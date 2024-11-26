class UserProfile {
  String bpFname;
  String bpTalId;
  String bpMobileNo;
  String bkProfile;
  String bpMname;
  String bpLname;
  String bpGender;
  String bpId;
  String bpEmail;

  UserProfile({
    required this.bpTalId,
    required this.bpFname,
    required this.bpMname,
    required this.bpLname,
    required this.bpMobileNo,
    required this.bpEmail,
    required this.bpId,
    required this.bkProfile,
    required this.bpGender,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      bpTalId: json['bp_tal_id'] ??'',
      bpFname: json['bp_fname'] ?? '',
      bpMname: json['bp_mname'] ?? '',
      bpLname: json['bp_lname'] ?? '',
      bpId: json['bp_id'] ?? '',
      bpMobileNo: json['bp_mobile_no'] ?? '',
      bkProfile: json['bk_profile'] ?? '',
      bpEmail: json['bp_email'] ?? '',
      bpGender: json['bp_gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bp_tal_id': bpTalId,
      'bp_id': bpId,
      'bp_fname': bpFname,
      'bp_mname': bpMname,
      'bp_lname': bpLname,
      'bp_mobile_no': bpMobileNo,
      'bk_profile': bkProfile,
      'bp_gender': bpGender,
    };
  }
}
