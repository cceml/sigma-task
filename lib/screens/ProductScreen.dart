import 'package:flutter/material.dart';
import '../ProductModel.dart';

class ProductScreen extends StatelessWidget {
  final ValueSetter<ProductModel> _valueSetter;

  ProductScreen(this._valueSetter);

  List<ProductModel> products = [
    ProductModel("T-shirt1", 50),
    ProductModel("T-shirt2", 60),
    ProductModel("T-shirt3", 70),
    ProductModel("T-shirt4", 80),
    ProductModel("T-shirt5", 90),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            trailing: Text(
              "₺${products[index].price}",
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              _valueSetter(products[index]);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: products.length);
  }
}
