class Product {
  final String? id;
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      images: List<String>.from(json['images']),
      category: json['category'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
    };
  }
}
