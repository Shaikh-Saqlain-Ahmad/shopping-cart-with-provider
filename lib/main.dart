import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_with_provider/provider/cart-provider.dart';
import 'package:shopping_cart_with_provider/ui/product-list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ShoppingList(),
          );
        },
      ),
    );
  }
}
