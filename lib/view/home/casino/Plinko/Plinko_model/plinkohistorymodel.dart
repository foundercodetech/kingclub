class PlinkoGameHistoryModel{
  final int? amount;
  final String? bet;
  final String? datetime;
  final String? gamesno;
  final int? id;
  final int? status;

  PlinkoGameHistoryModel({
    required this.amount,
    required this.bet,
    required this.datetime,
    required this.gamesno,
    required this.id,
    required this.status,
  });
  factory PlinkoGameHistoryModel.fromJson(Map<String, dynamic> json){
    return PlinkoGameHistoryModel(
      amount: json["amount"],
      bet: json["bet"],
      datetime: json["datetime"],
      gamesno: json["gamesno"],
      id: json["id"],
      status: json["status"],
    );
  }
}

