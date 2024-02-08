import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_with_provider/constants/constant.dart';
import 'package:shopping_cart_with_provider/constants/db-helper.dart';
import 'package:shopping_cart_with_provider/models/cart-model.dart';
import 'package:shopping_cart_with_provider/provider/cart-provider.dart';
import 'package:shopping_cart_with_provider/ui/cart-screen.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  DbHelper? dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shopping List",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primary, secondary])),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              child: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ));
                      },
                      child: Badge(child: Text(value.getCounter().toString())));
                },
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: FruitNames.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                FruitImage[index].toString(),
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(FruitNames[index].toString()),
                                  Text(ProductUnit[index].toString() +
                                      ProductPrice[index].toString() +
                                      r"$"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        dbHelper!
                                            .insert(Cart(
                                                id: index,
                                                ProductId: index.toString(),
                                                ProductName: FruitNames[index]
                                                    .toString(),
                                                inPrice: ProductPrice[index],
                                                ProductPrice:
                                                    ProductPrice[index],
                                                quantity: 1,
                                                unitTag: ProductUnit[index]
                                                    .toString(),
                                                image: FruitImage[index]
                                                    .toString()))
                                            .then((value) {
                                          debugPrint("Product added to cart");
                                          cart.addTotalPrice(double.parse(
                                              ProductPrice[index].toString()));
                                          cart.addCounter();
                                        }).onError((error, stackTrace) {
                                          debugPrint(
                                              "Error encountered at add to cart ${error.toString()}");
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: const Center(
                                            child: Text("Add to Cart")),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ]),
                    );
                  }))
        ]),
      ),
    );
  }
}
