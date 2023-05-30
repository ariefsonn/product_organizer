import 'package:flutter/material.dart';
import 'package:product_organizer/base/constant.dart';
import 'package:product_organizer/domain/entities/demand.dart';
import 'package:product_organizer/domain/usecases/demand_cases.dart';

class DemandPage extends StatefulWidget {
  const DemandPage({Key? key}) : super(key: key);

  @override
  State<DemandPage> createState() => _DemandPageState();
}

class _DemandPageState extends State<DemandPage> {
  final cdemand = TextEditingController();
  final demand = DemandImpl();
  late Future<Demand> amount;

  @override
  void initState() {
    amount = demand.getDemand();
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Permintaan Terkini',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container (
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20),
                ),
              ),
              child: Column(
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
                  FutureBuilder(
                    future: amount,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data?.jumlah_demand}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Update Permintaan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(top: 4, left: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF225050),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Update Permintaan',
                  hintStyle: TextStyle(fontSize: 22, color: Color(0xFF4F7777)),
                ),
                keyboardType: TextInputType.number,
                controller: cdemand,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  demand.updateDemand(cdemand.text, context);
                  demand.storeDemand(cdemand.text, context);
                });
              },
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0BB68),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Center(
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                          color: Color(0xFF212101),
                          fontWeight: FontWeight.w700,
                          fontSize: 15.5
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
