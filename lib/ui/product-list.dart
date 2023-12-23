import 'package:flutter/material.dart';
import 'package:shopping_cart_with_provider/constants/constant.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping List"),
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
              child: Badge(child: Icon(Icons.shopping_bag_outlined)),
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
                                    child: Container(
                                      child: Center(child: Text("Add to Cart")),
                                      height: 35,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
