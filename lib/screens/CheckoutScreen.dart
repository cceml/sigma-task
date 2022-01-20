import 'package:flutter/material.dart';
import 'package:sigmatask/ProductModel.dart';

class CheckoutScreen extends StatelessWidget {
  final List<OrderItemModel> cart;
  final num sum;
  final ValueSetter<int> onRemoved;

  CheckoutScreen(this.cart, this.sum, {required this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          itemBuilder: (context, index) {
            final orderItem = cart[index];
            return ListTile(
              title: Text(orderItem.product.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onRemoved(orderItem.id);
                },
              ),
              subtitle: Text(
                "₺${cart[index].product.price}",
                style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: cart.length,
          shrinkWrap: true,
        ),
        const Divider(),
        Text("Total : ₺$sum"),
      ],
    );
  }
}
