import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_organizer/domain/entities/forecast.dart';
import 'package:product_organizer/domain/entities/stock.dart';
import 'package:product_organizer/domain/helper/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_organizer/layout/layout_navbar.dart';

class StockImpl {
  static final _host = Uri.http(Helper.api, '/');

  Future<Stock> getStock() async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/stock'),
      );
      if (response.statusCode == 200) {
        return Stock.fromJson(jsonDecode(response.body));
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future<Forecast> getForecast() async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/demand/forcase'),
      );
      if (response.statusCode == 200) {
        return Forecast.fromJson(jsonDecode(response.body));
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future<void> updateStock(String price, String amount, BuildContext ctx) async {
    try {
      final response = await http.post(
          _host.replace(path: '/api/update/1/stock'),
          body: <String, String> {
            'harga' : price,
            'stock' : amount,
          }
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text("Update Succesfully"),
        ));
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future<void> storeStock(String amount, BuildContext ctx) async {
    try {
      final response = await http.post(
          _host.replace(path: '/api/store/stock'),
          body: <String, String> {
            'history_stok' : amount,
          }
      );
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(builder: (c) => const LayoutNavbar(index: 1)), (route) => false);
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
}
