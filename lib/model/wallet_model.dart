class WalletModel {
  final String? wallet;
  final String? winning_wallet;
  final String? commission;
  final String? bonus;


  WalletModel({
    required this.wallet,
    required this.winning_wallet,
    required this.commission,
    required this.bonus,

  });
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      wallet: json['wallet'],
      winning_wallet: json['winning_wallet'],
      commission: json['commission'],
      bonus: json['bonus'],

    );
  }
}