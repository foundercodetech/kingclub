class GreenListModel{
  String? colour;
  String? multiplier;

  GreenListModel({ this.colour,
    this.multiplier});
  factory GreenListModel.fromJson(Map<String, dynamic>json) => GreenListModel(
    colour: json["colour"],
    multiplier: json["multiplier"],
  );
}

