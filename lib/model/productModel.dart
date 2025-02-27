class Product {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  // Konversi dari JSON (misalnya dari API)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      stock: json['stock'],
    );
  }

  // Konversi ke JSON (misalnya untuk menyimpan di database)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'stock': stock,
    };
  }
}
