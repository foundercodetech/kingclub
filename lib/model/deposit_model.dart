class DepositModel {
  final String? id;
  final String? userId;
  final String? amount;
  final String? type;
  final String? status;
  final String? orderid;
  final String? created_at;


  DepositModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.orderid,
    required this.created_at,
  });
  factory DepositModel.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    print("json['id'] deposit");
    return DepositModel(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      type: json['type'],
      status: json['status'],
      orderid: json['orderid'],
      created_at: json['created_at'],
    );
  }
}