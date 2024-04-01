class TcModel {
  final String? name;
  final String? disc;


  TcModel({
    required this.name,
    required this.disc,

  });

  factory TcModel.fromJson(Map<dynamic, dynamic> json) {
    return TcModel(
      name: json['name'],
      disc: json['disc'],

    );
  }
}
