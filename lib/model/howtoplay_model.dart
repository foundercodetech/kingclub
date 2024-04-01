class HowtoplayModel {
  
  final String? id;
  final String? gameid;
  final String? gamename;
  final String? description;
  final String? rules;


  HowtoplayModel({
    required this.id,
    required this.gameid,
    required this.gamename,
    required this.description,
    required this.rules,

  });

  factory HowtoplayModel.fromJson(Map<dynamic, dynamic> json) {
    return HowtoplayModel(
      id: json['id'],
      gameid: json['gameid'],
      gamename: json['gamename'],
      description: json['description'],
      rules: json['rules'],

    );
  }
}
