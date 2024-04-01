class PromotionCountModel {

  String? total_user_count;
  String? today_user;
  String? total_commission;
  String? refer_bonus;

  PromotionCountModel({
    required this.total_user_count,
    required this.today_user,
    required this.total_commission,
    required this.refer_bonus,

  });

  factory PromotionCountModel.fromJson(Map<String, dynamic>json) {
    return PromotionCountModel(
      total_user_count: json['total_user_count'],
      today_user: json['today_user'],
      total_commission: json['total_commission'],
      refer_bonus: json['refer_bonus'],

    );
  }
}
