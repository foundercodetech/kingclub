class lastfifteen{
  String? win_number;


  lastfifteen({
    required this.win_number,

  });
  factory lastfifteen.fromJson(Map<String, dynamic>json) => lastfifteen(
      win_number: json["win_number"],
  );

}