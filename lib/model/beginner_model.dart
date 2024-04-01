class BeginnerModel {
  final String? name;
  final String? disc;


  BeginnerModel({
    required this.name,
    required this.disc,

  });

  factory BeginnerModel.fromJson(Map<dynamic, dynamic> json) {
    return BeginnerModel(
      name: json['name'],
      disc: json['disc'],

    );
  }
}
