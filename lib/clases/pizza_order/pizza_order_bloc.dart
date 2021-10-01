import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';

enum PizzaSizeValue {
  s,
  m,
  l,
}

class PizzaSizeState {
  PizzaSizeState(this.value) : factor = getFactorBySize(value);
  final PizzaSizeValue value;
  final double factor;

  static double getFactorBySize(PizzaSizeValue value) {
    switch (value) {
      case PizzaSizeValue.s:
        return 0.75;
      case PizzaSizeValue.m:
        return 0.85;
      case PizzaSizeValue.l:
        return 1.0;
    }
  }
}

class PizzaOrderBloc extends ChangeNotifier {
  final listIngredients = <Ingredients>[];
  final notifierTotal = ValueNotifier<int>(15);
  var deletedIngredient;
  var notifierDeletedIngredient = ValueNotifier<bool>(false);
  final notifyFocussed = ValueNotifier(false);
  final notifierPizzaSize =
      ValueNotifier<PizzaSizeState>(PizzaSizeState(PizzaSizeValue.m));

  void addIngredient(Ingredients ingredient) {
    listIngredients.add(ingredient);
    notifierDeletedIngredient.value = false;
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
    deletedIngredient = ingredient;
    notifierDeletedIngredient.value = true;
    notifierTotal.value--;
  }

  void refreshDeletedIngredient() {
    deletedIngredient = null;
    notifierDeletedIngredient.value = false;
  }
}
