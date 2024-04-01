class Bethistorycon{
  int? id;
  String? datetime;
  int? status;
  int? totalamounts;
  int? gamesno;
  int? dragon;
  int? tie;
  int? tiger;
  int? winner;
  int? winning_amount;
  Bethistorycon({
    required this.id,
    required this.datetime,
    required this.status,
    required this.totalamounts,
    required this.gamesno,
    required this.dragon,
    required this.tie,
    required this.tiger,
    required this.winner,
    required this.winning_amount,
  });
  factory Bethistorycon.fromJson(Map<String, dynamic>json) => Bethistorycon(
    id: json["id"],
    datetime: json["datetime"],
    status: json["status"],
    totalamounts: json["totalamounts"],
    gamesno: json["gamesno"],
    dragon: json["dragon"],
    tie: json["tie"],
    tiger: json["tiger"],
    winner: json["winner"],
    winning_amount: json["winning_amount"],
  );
}