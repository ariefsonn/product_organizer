class Stock {
  final dynamic id;
  final dynamic stock;
  final dynamic harga;

  const Stock({
    required this.id,
    required this.harga,
    required this.stock,
  });

  factory Stock.fromJson(Map<dynamic, dynamic> json) {
    return Stock(
      id: json['id'],
      stock: json['stock'],
      harga: json['harga'],
    );
  }
}