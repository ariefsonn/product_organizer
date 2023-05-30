import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_organizer/domain/entities/demand.dart';
import 'package:product_organizer/domain/helper/constant.dart';

import '../../layout/layout_navbar.dart';

class DemandImpl {
  static final _host = Uri.http(Helper.api, '/');

  Future<Demand> getDemand() async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/demand'),
      );
      if (response.statusCode == 200) {
        return Demand.fromJson(jsonDecode(response.body));
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future<void> updateDemand(String amount, BuildContext ctx) async {
    try {
      final response = await http.post(
          _host.replace(path: '/api/update/1/demand'),
          body: <String, String> {
            'jumlah_demand' : amount,
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
  Future<void> storeDemand(String amount, BuildContext ctx) async {
    try {
      final response = await http.post(
          _host.replace(path: '/api/store_demand'),
          body: <String, String> {
            'history_demand' : amount,
          }
      );
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(ctx, MaterialPageRoute(builder: (c) => const LayoutNavbar(index: 2)), (route) => false);
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
}