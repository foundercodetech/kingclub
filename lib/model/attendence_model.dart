// ignore_for_file: non_constant_identifier_names

class AttendenceModel {

  final String? id;
  final String? amount;
  final String? status;
  final String? datetime;

  AttendenceModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.datetime,

  });
  factory AttendenceModel.fromJson(Map<dynamic, dynamic> json) {
    return AttendenceModel(
      id: json['id'],
     
      amount: json['amount'], 
      status: json['status'],
      datetime: json['datetime'],

    );
  }
}