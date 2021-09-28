import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';

class PizzaOrderBloc extends ChangeNotifier {
  final listIngredients = <Ingredients>[];
  final notifierTotal = ValueNotifier<int>(15);
  var deletedIngredient;
  var notifierDeletedIngredient = ValueNotifier<bool>(true);

  void addIngredient(Ingredients ingredient) {
    listIngredients.add(ingredient);
    notifierTotal.value++;
  }

  bool containsIngredients(Ingredients ingredient) {
    for (Ingredients i in listIngredients) {
      if (i.compare(ingredient)) {
        return true;
      }
    }
    return false;
  }

  void removeIngredients(Ingredients ingredient) {
    listIngredients.remove(ingredient);
    notifierDeletedIngredient.value = false;
    notifierTotal.value--;
    // deletedIngredient = ingredient;
  }

  void refreshDeletedIngredient() {
    notifierDeletedIngredient.value = true;
  }
}
