class Contactusmodel {
  final String? name;
  final String? disc;
  final String? image;


  Contactusmodel({
    required this.name,
    required this.disc,
    required this.image,

  });

  factory Contactusmodel.fromJson(Map<dynamic, dynamic> json) {
    return Contactusmodel(
      name: json['name'],
      disc: json['disc'],
      image: json['image'],

    );
  }
}
