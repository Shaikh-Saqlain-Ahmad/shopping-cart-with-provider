class Cart {
  late final int? id;
  final String? ProductId;
  final String? ProductName;
  final int? inPrice;
  final int? ProductPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart(
      {required this.id,
      required this.ProductId,
      required this.ProductName,
      required this.inPrice,
      required this.ProductPrice,
      required this.quantity,
      required this.unitTag,
      required this.image});
  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        ProductId = res['ProductId'],
        ProductName = res['ProductName'],
        inPrice = res['inPrice'],
        ProductPrice = res['ProdcutPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': ProductId,
      'ProductName': ProductName,
      'inPrice': inPrice,
      'ProductPrice': ProductPrice,
      "quantity": quantity,
      "unitTag": unitTag,
      'image': image,
    };
  }
}
