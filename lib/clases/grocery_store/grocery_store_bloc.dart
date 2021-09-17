import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/models/grocery_products.dart';

// Monitoriar y manejar estados de la app (OJO) muy importante
enum GroceryState {
  normal,
  details,
  cart,
}

class GroceryStoreBloc with ChangeNotifier {
  GroceryState groceryState = GroceryState.normal;
// accediendo a la lista de productos a traves del bloc
  List<GroceryProduct> catalog = List.unmodifiable(groceryProducts);
  List<GroceryProductItem> cart = [];

  void changeToNormal() {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  // void changeToDetails() {
  //   groceryState = GroceryState.details;
  //   notifyListeners();
  // }

  void addProduct(GroceryProduct product) {
    for (GroceryProductItem item in cart) {
      if (item.product.name == product.name) {
        item.plus();
        notifyListeners();
        return;
      }
    }
    cart.add(
      GroceryProductItem(product: product),
    );
    notifyListeners();
  }

  void deleteProduct(GroceryProductItem productItem) {
    cart.remove(productItem);
    notifyListeners();
  }

  int cartTotalElemnts() => cart.fold(
      0, (previousValue, element) => previousValue + element.quantity);

  double cartTotalPrice() => cart.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.quantity * element.product.price));
}

class GroceryProductItem {
  GroceryProductItem({this.quantity = 1, required this.product});
  int quantity;
  final GroceryProduct product;
  void plus() {
    quantity++;
  }

  void minus() {
    quantity--;
  }
}
