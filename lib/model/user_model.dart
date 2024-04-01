class UserModel{

  String? id;
  String? msg;
  String? status;

  UserModel({
     this.id,
     this.msg,
     this.status,

  });
  factory UserModel.fromJson(Map<String, dynamic>json) => UserModel(
    id: json["id"],
    msg: json["msg"],
    status: json["status"],
  );
}
