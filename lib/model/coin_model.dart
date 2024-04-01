class CoinModel {
  
  final String? id;
  final String? name;
  final String? first;
  final String? addon;
  final String? INR;
  final String? USDT;
 

  CoinModel({
    required this.id,
    required this.name,
    required this.first,
    required this.addon,
    required this.INR,
    required this.USDT,
    
  });
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    print(json['id']);
    print("json['id'] deposit");
    return CoinModel(
     id: json['id'],
     name: json['name'],
     first: json['first'],
     addon: json['addon'],
     INR: json['INR'],
     USDT: json['USDT'],
      
  );
  }
}