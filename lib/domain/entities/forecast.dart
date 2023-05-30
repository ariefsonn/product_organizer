class Forecast {
  final dynamic forecast;

  const Forecast({
    required this.forecast,
  });

  factory Forecast.fromJson(Map<dynamic, dynamic> json) {
    return Forecast(forecast: json['forecast_stock']);
  }
}