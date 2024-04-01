class AddacountViewModel {

  final String? id;
  final String? user_id;
  final String? name;
  final String? account_no;
  final String? ifsc;
  final String? branch;
  final String? bank_name;
  final String? status;


  AddacountViewModel({
    required this.id,
    required this.user_id,
    required this.name,
    required this.account_no,
    required this.ifsc,
    required this.branch,
    required this.bank_name,
    required this.status,

  });
  factory AddacountViewModel.fromJson(Map<dynamic, dynamic> json) {
    print(json['id']);
    print("json['id'] deposit");
    return AddacountViewModel(
      id: json['id'],
      user_id: json['user_id'],
      name: json['name'],
      account_no: json['account_no'],
      ifsc: json['ifsc'],
      branch: json['branch'],
      bank_name: json['bank_name'],
      status: json['status'],

    );
  }
}