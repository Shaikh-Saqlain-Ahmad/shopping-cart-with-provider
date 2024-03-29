import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_with_provider/constants/db-helper.dart';
import 'package:shopping_cart_with_provider/models/cart-model.dart';

class CartProvider with ChangeNotifier {
  DbHelper db = DbHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('cart_item', _counter);
    pref.setDouble("total_price", _totalPrice);
    notifyListeners();
  }

  void _getPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble("total_price") ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPref();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPref();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItem();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPref();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPref();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItem();
    return _totalPrice;
  }
}
