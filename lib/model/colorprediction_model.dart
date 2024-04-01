// ignore_for_file: non_constant_identifier_names, unnecessary_question_mark

class ColorPredictionModel {

  final String? id;
  final String? number;
  final String? colour;
  final String? gamesno;
  final String? price;
  final String? status;
  final String? datetime;

  ColorPredictionModel({
    required this.id,
    required this.number,
    required this.colour,
    required this.gamesno,
    required this.price,
    required this.status,
    required this.datetime,

  });
  factory ColorPredictionModel.fromJson(Map<String, dynamic?> json) {
    print(json['id']);
    print("json['id'] deposit");
    return ColorPredictionModel(
      id: json['id'],
      number: json['number'],
      colour: json['colour'],
      gamesno: json['gamesno'],
      price: json['price'],
      status: json['status'],
      datetime: json['datetime'],

    );
  }
}