import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sigmatask/screens/CheckoutScreen.dart';
import 'package:sigmatask/screens/ProductScreen.dart';
import 'package:sigmatask/signup.dart';
import 'ProductModel.dart';
import 'package:intl/intl.dart';
import 'dart:io';

String getCurrency() {
  var format = NumberFormat.simpleCurrency(locale: 'TR-tr', name: 'TRY');
  return format.currencySymbol;
}

void main() => runApp(const index());

class index extends StatelessWidget {
  const index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TASK',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CartApp());
  }
}

class CartApp extends StatefulWidget {
  const CartApp({Key? key}) : super(key: key);

  @override
  _CartAppState createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> {
  List<OrderItemModel> cart = [];

  int sum = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text("Home Page"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((user) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginP()),
                        (route) => false);
                  });
                },
                icon: const Icon(Icons.logout_outlined)),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Products",
              ),
              Tab(
                text: "Card",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductScreen((selectedProduct) {
              final orderItem = OrderItemModel(
                  id: DateTime.now().microsecondsSinceEpoch ~/ 100,
                  product: selectedProduct);
              setState(() {
                {
                  cart.add(orderItem);
                } //update
                sum = 0;
                cart.forEach((item) {
                  sum = sum + (item.quantity * item.product.price);
                });
              });
            }),
            CheckoutScreen(
              cart,
              sum,
              onRemoved: (id) {
                setState(() {
                  cart.removeWhere((element) => element.id == id);
                  sum = 0;
                  cart.forEach((item) {
                    sum = sum + (item.quantity * item.product.price);
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
