import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_with_provider/models/cart-model.dart';
import 'package:shopping_cart_with_provider/provider/cart-provider.dart';

import '../constants/constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Products",
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
                return Badge(child: Text(value.getCounter().toString()));
              },
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(children: [
        FutureBuilder(
            future: cart.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      snapshot.data![index].image.toString(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data![index].ProductName
                                            .toString()),
                                        Text(snapshot.data![index].unitTag
                                                .toString() +
                                            snapshot.data![index].ProductPrice
                                                .toString() +
                                            r"$"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
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
                        }));
              } else {
                return Text("");
              }
            })
      ]),
    ));
  }
}
