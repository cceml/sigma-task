class ProductModel {
  String name;
  int price;

  ProductModel(this.name, this.price);
}

class OrderItemModel {
  int id;
  ProductModel product;
  int quantity;

  OrderItemModel({
    required this.id,
    required this.product,
    this.quantity = 1,
  });
}
