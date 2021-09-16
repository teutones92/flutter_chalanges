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

  void changeToNormal() {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  void changeToDetails() {
    groceryState = GroceryState.details;
    notifyListeners();
  }
}
