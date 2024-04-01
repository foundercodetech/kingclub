class GetwayModel {
  final String? id;
  final String? image;
  final String? name;
  final String? status;


  GetwayModel({
    required this.id,
    required this.image,
    required this.name,
    required this.status,

  });
  factory GetwayModel.fromJson(Map<String, dynamic> json) {
    return GetwayModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],

    );
  }
}