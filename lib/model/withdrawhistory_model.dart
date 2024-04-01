// ignore_for_file: non_constant_identifier_names

class WithdrawModel {

  final String? id;
  final String? user_id;
  final String? amount;
  final String? account_id;
  final String? status;
  final String? date;
  final String? accountno;

  WithdrawModel({
    required this.id,
    required this.user_id,
    required this.amount,
    required this.account_id,
    required this.status,
    required this.date,
    required this.accountno,
  });
  factory WithdrawModel.fromJson(Map<dynamic, dynamic> json) {
    return WithdrawModel(
      id: json['id'],
      user_id: json['user_id'],
      amount: json['amount'],
      account_id: json['account_id'],
      status: json['status'],
      date: json['date'],
      accountno: json['accountno'],
    );
  }
}