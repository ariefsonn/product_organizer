import 'package:flutter/material.dart';
import 'package:product_organizer/base/constant.dart';
import 'package:product_organizer/domain/entities/demand.dart';
import 'package:product_organizer/domain/entities/forecast.dart';
import 'package:product_organizer/domain/entities/stock.dart';
import 'package:product_organizer/domain/usecases/demand_cases.dart';
import 'package:product_organizer/domain/usecases/stock_cases.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final demand = DemandImpl();
  final stock = StockImpl();

  late Future<Stock> f_stock;
  late Future<Demand> f_demand;
  late Future<Forecast> forecast;

  @override
  void initState() {
    f_stock = stock.getStock();
    f_demand = demand.getDemand();
    forecast = stock.getForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Color(KColor.mainBackground),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Saturday',
                      style: TextStyle(
                        color: Color(KColor.thirdFontColor),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '17 December 2023',
                      style: TextStyle(
                        color: Color(KColor.thirdFontColor),
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, bottom: 30),
              width: double.infinity,
              height: 2,
              decoration: const BoxDecoration(
                color: Color(KColor.stringColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20),
                ),
              ),
              child: FutureBuilder(
                future: forecast,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Target Stock',
                          style: TextStyle(
                            color: Color(0xFF9DABAB),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${snapshot.data?.forecast}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 15),
                          width: double.infinity,
                          height: 1,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9DABAB),
                          ),
                        ),
                        FutureBuilder(
                          future: f_stock,
                          builder: (c, s) {
                            if (s.hasData) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Harga',
                                        style: TextStyle(
                                          color: Color(0xFF9DABAB),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\$${s.data?.harga}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else if (s.hasError) {
                              return Text('${s.error}');
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height: 85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15),
                ),
              ),
              child: FutureBuilder(
                future: f_stock,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Stok Terkini',
                          style: TextStyle(
                            color: Color(0xFF9DABAB),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${snapshot.data?.stock}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
              width: double.infinity,
              height: 85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15),
                ),
              ),
              child: FutureBuilder(
                future: f_demand,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Permintaan Terkini',
                          style: TextStyle(
                            color: Color(0xFF9DABAB),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${snapshot.data?.jumlah_demand}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
