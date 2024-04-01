class SliderModel{

  final String?  id;
  final String? title;
  final String? image;
  final String? status;

  SliderModel({
    this.id,
    this.title,
    this.image,
    this.status,

  });
  factory SliderModel.fromJson(Map<String, dynamic>json){
    print(json["id"]);
    print("sdfghj");
    return SliderModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        status: json["status"],
    );
  }
  // factory SliderModel.fromJson(Map<String, dynamic>json) => SliderModel(
  //   id: json["id"],
  //   title: json["title"],
  //   image: json["image"],
  //   status: json["status"],
  // );

}
