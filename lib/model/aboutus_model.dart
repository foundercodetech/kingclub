class AboutusModel {
  final String? name;
  final String? disc;


  AboutusModel({
    required this.name,
    required this.disc,

  });

  factory AboutusModel.fromJson(Map<dynamic, dynamic> json) {
    return AboutusModel(
      name: json['name'],
      disc: json['disc'],

    );
  }
}
