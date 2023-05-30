class Demand {
  final dynamic id;
  final dynamic jumlah_demand;

  const Demand ({
   required this.id,
   required this.jumlah_demand,
  });

  factory Demand.fromJson(Map<dynamic, dynamic> json) {
    return Demand(
      id: json['id'],
      jumlah_demand: json['jumlah_demand'],
    );
  }
}