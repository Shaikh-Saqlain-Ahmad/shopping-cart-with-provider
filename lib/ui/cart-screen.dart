import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_with_provider/constants/db-helper.dart';
import 'package:shopping_cart_with_provider/models/cart-model.dart';
import 'package:shopping_cart_with_provider/provider/cart-provider.dart';
import 'package:shopping_cart_with_provider/ui/reusable-widget.dart';

import '../constants/constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DbHelper dbHelper = DbHelper();
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ));
              },
              child: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Badge(child: Text(value.getCounter().toString()));
                },
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ]),
      body: Column(children: [
        FutureBuilder(
            future: cart.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                // debugPrint("snapshot data ${snapshot.data.toString()}");

                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.isEmpty) {
                            return const Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/emptycart.jpg'),
                                ),
                                Text("Explore Products")
                              ],
                            );
                          } else {
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot
                                                  .data![index].ProductName
                                                  .toString()),
                                              InkWell(
                                                  onTap: () {
                                                    dbHelper.deleteItem(snapshot
                                                        .data![index].id!);
                                                    cart.removeCounter();
                                                    cart.removeTotalPrice(
                                                        double.parse(snapshot
                                                            .data![index]
                                                            .ProductPrice
                                                            .toString()));
                                                  },
                                                  child: const Icon(
                                                      Icons.delete_rounded))
                                            ],
                                          ),
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
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = snapshot
                                                            .data![index]
                                                            .quantity!;
                                                        int price = snapshot
                                                            .data![index]
                                                            .ProductPrice!;
                                                        quantity--;
                                                        int? newPrice =
                                                            price * quantity;
                                                        if (quantity > 0) {
                                                          dbHelper
                                                              .updateQuantity(
                                                                  Cart(
                                                            id: snapshot
                                                                .data![index]
                                                                .id,
                                                            ProductId: snapshot
                                                                .data![index]
                                                                .ProductId,
                                                            ProductName: snapshot
                                                                .data![index]
                                                                .ProductName,
                                                            inPrice: snapshot
                                                                .data![index]
                                                                .inPrice,
                                                            ProductPrice:
                                                                newPrice,
                                                            quantity: quantity,
                                                            unitTag: snapshot
                                                                .data![index]
                                                                .unitTag,
                                                            image: snapshot
                                                                .data![index]
                                                                .image,
                                                          ))
                                                              .then((value) {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .inPrice!
                                                                    .toString()));
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            debugPrint(
                                                                "error updating cart ${error.toString()}");
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                          Icons.remove_circle),
                                                    ),
                                                    Text(snapshot
                                                        .data![index].quantity
                                                        .toString()),
                                                    InkWell(
                                                        onTap: () {
                                                          int quantity =
                                                              snapshot
                                                                  .data![index]
                                                                  .quantity!;
                                                          int price = snapshot
                                                              .data![index]
                                                              .ProductPrice!;
                                                          quantity++;
                                                          int? newPrice =
                                                              price * quantity;
                                                          dbHelper
                                                              .updateQuantity(
                                                                  Cart(
                                                            id: snapshot
                                                                .data![index]
                                                                .id,
                                                            ProductId: snapshot
                                                                .data![index]
                                                                .ProductId,
                                                            ProductName: snapshot
                                                                .data![index]
                                                                .ProductName,
                                                            inPrice: snapshot
                                                                .data![index]
                                                                .inPrice,
                                                            ProductPrice:
                                                                newPrice,
                                                            quantity: quantity,
                                                            unitTag: snapshot
                                                                .data![index]
                                                                .unitTag,
                                                            image: snapshot
                                                                .data![index]
                                                                .image,
                                                          ))
                                                              .then((value) {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.addTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .inPrice!
                                                                    .toString()));
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            debugPrint(
                                                                "error updating cart ${error.toString()}");
                                                          });
                                                        },
                                                        child: const Icon(
                                                            Icons.add_circle))
                                                  ],
                                                ),
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
                          }
                        }));
              } else {
                return const Text("");
              }
            }),
        Consumer<CartProvider>(builder: (context, value, child) {
          return Visibility(
            visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                ? false
                : true,
            child: Column(
              children: [
                ReusableWidget(
                    title: 'Sub-Total',
                    value: r'$' + value.getTotalPrice().toStringAsFixed(2))
              ],
            ),
          );
        })
      ]),
    ));
  }
}
