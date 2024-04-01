class MyBetModel {
  String? id;
  String? gamesno;
  String? amount;
  String? uid;
  String? status;
  String? datetime;
  String? cashoutAmount;
  String? multiplier;
  MyBetModel(
      {this.id,
      this.gamesno,
      this.amount,
      this.uid,
      this.status,
      this.datetime,
      this.cashoutAmount,
      this.multiplier,});
  factory MyBetModel.fromJson(Map<String, dynamic> json) => MyBetModel(
        id: json["id"].toString(),
        gamesno: json["gamesno"].toString(),
        amount: json["amount"].toString(),
        uid: json["uid"].toString(),
        status: json["status"].toString(),
        datetime: json["datetime"].toString(),
        cashoutAmount: json["cashout_amount"].toString(),
        multiplier: json["multiplier"].toString(),
      );
}


