import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

Future<List<Product>> loadProducts() async {
  final data = await rootBundle.loadString('assets/products.json');
  final List<dynamic> jsonList = json.decode(data);
  return jsonList.map((json) => Product.fromJson(json)).toList();
}
