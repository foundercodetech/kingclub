
class ResultHistoryModel{
  String?id;
  String?gamesno;
  String?result;
  String?status;
  String?datetime;

  ResultHistoryModel({
    this.id,this.gamesno,this.result,this.status,this.datetime
});
  factory ResultHistoryModel.fromJson(Map<String, dynamic>json) => ResultHistoryModel(
    id: json["id"].toString(),
    gamesno: json["gamesno"].toString(),
    result: json["result"].toString(),
    status: json["status"].toString(),
    datetime: json["datetime"].toString(),
  );
}


