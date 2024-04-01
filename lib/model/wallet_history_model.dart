class WalletHistoryModal {
  final String? id;
  final String? userId;
  final String? amount;
  final String? type;
  final String? status;
  final String? datetime;



  WalletHistoryModal({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.datetime,

  });
  factory WalletHistoryModal.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    print("json['id'] deposit");
    return WalletHistoryModal(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      datetime: json['datetime'],

    );
  }
}