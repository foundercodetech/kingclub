class NotificationModel {
  final String? name;
  final String? disc;
  final String? image;


  NotificationModel({
    required this.name,
    required this.disc,
    required this.image,

  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      name: json['name'],
      disc: json['disc'],
      image: json['image'],

    );
  }
}
