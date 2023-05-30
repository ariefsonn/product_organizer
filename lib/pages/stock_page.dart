import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:product_organizer/base/constant.dart';
import 'package:product_organizer/domain/entities/stock.dart';
import 'package:product_organizer/domain/usecases/stock_cases.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final cprice = TextEditingController();
  final cstock = TextEditingController();

  final stock = StockImpl();
  late Future<Stock> field;

  @override
  void initState() {
    field = stock.getStock();
    super.initState();
  }

  void update(AsyncSnapshot snapshot) {
    setState(() {
      cstock.text = '${snapshot.data?.stock}';
      cprice.text = '${snapshot.data?.harga}';
    });
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
                  'Stock Terkini',
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
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20),
                ),
              ),
              child: FutureBuilder(
                future: field,
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
                          Text(
                            '${snapshot.data?.stock}',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Harga Terkini',
                                style: TextStyle(
                                  color: Color(0xFF9DABAB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${snapshot.data?.harga}',
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
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Update Stock',
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
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF225050),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: cprice,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Update Harga',
                  hintStyle: const TextStyle(fontSize: 22, color: Color(0xFF4F7777)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/dollar.png', width: 5, height: 5, color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
            ),
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
                controller: cstock,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Update Stok',
                  hintStyle: TextStyle(fontSize: 22, color: Color(0xFF4F7777)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  stock.storeStock(cstock.text, context);
                  stock.updateStock(cprice.text, cstock.text, context);
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
