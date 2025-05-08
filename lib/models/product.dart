class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    image: json['image'],
    description: json['description'],
  );
}
