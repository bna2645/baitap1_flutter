import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/product_service.dart';
import 'screens/detail_screen.dart';

void main() => runApp(const ProductApp());

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  int _currentPage = 0;
  static const int _perPage = 10;

  @override
  void initState() {
    super.initState();
    loadProducts().then((products) {
      setState(() {
        _products = products;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = _currentPage * _perPage;
    final end = (_currentPage + 1) * _perPage;
    final items = _products.sublist(
      start,
      end > _products.length ? _products.length : end,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách sản phẩm')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final product = items[index];
                return ListTile(
                  leading: Image.asset(product.image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.name),
                  subtitle: Text('${product.price} VND'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _currentPage > 0
                    ? () => setState(() => _currentPage--)
                    : null,
                child: const Text("Trang trước"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: (_currentPage + 1) * _perPage < _products.length
                    ? () => setState(() => _currentPage++)
                    : null,
                child: const Text("Trang sau"),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
