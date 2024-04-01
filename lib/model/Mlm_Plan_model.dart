class MlmPlanModel {
  final String? id;
  final String? commission;
  final String? count;
  final String? name;


  MlmPlanModel({
    required this.id,
    required this.commission,
    required this.count,
    required this.name,

  });
  factory MlmPlanModel.fromJson(Map<String, dynamic> json) {
    return MlmPlanModel(
      id: json['id'],
      commission: json['commission'],
      count: json['count'],
      name: json['name'],

    );
  }
}