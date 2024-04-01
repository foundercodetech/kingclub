class UserProfile {
  final dynamic id;
  final dynamic fullName;
  final dynamic mobile;
  final dynamic email;
  final dynamic wallet;
  final dynamic winningWallet;
  final dynamic accountNoId;
  final dynamic password;
  final dynamic photo;
  final dynamic aadhar;
  final dynamic aadhars;
  final dynamic ownRef;
  final dynamic referralCode;
  final dynamic referralUserId;
  final dynamic custId;
  final dynamic status;
  final dynamic verification;
  final dynamic roleId;
  final dynamic age;
  final dynamic bonus;
  final dynamic mlmWallet;
  final dynamic mlmStatus;
  final dynamic mlmPlan;
  final dynamic levelFirstStatus;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic commission;
  final dynamic username;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.wallet,
    required this.winningWallet,
    required this.accountNoId,
    required this.password,
    required this.photo,
    required this.aadhar,
    required this.aadhars,
    required this.ownRef,
    required this.referralCode,
    required this.referralUserId,
    required this.custId,
    required this.status,
    required this.verification,
    required this.roleId,
    required this.age,
    required this.bonus,
    required this.mlmWallet,
    required this.mlmStatus,
    required this.mlmPlan,
    required this.levelFirstStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.commission,
    required this.username,
  });

  factory UserProfile.fromJson(Map<dynamic, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullName: json['full_name'],
      mobile: json['mobile'],
      email: json['email'],
      wallet: json['wallet'],
      winningWallet: json['winning_wallet'],
      accountNoId: json['accountno_id'],
      password: json['password'],
      photo: json['photo'],
      aadhar: json['aadhar'],
      aadhars: json['aadhars'],
      ownRef: json['ownref'],
      referralCode: json['referral_code'],
      referralUserId: json['referral_user_id'],
      custId: json['custid'],
      status: json['status'],
      verification: json['verification'],
      roleId: json['roleid'],
      age: json['age'],
      bonus: json['bonus'],
      mlmWallet: json['mlm_wallet'],
      mlmStatus: json['mlm_status'],
      mlmPlan: json['mlm_plan'],
      levelFirstStatus: json['level_first_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      commission: json['commission'],
      username: json['username'],
    );
  }
}
