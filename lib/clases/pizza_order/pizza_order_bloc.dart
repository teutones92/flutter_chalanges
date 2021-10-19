import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:flutter/src/rendering/proxy_box.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';

class PizzaMetadata {
  PizzaMetadata(this.imageBytes, this.position, this.size);
  final Uint8List imageBytes;
  final Offset position;
  final Size size;
}

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
  final notifierPizzaboxAnimation = ValueNotifier<bool>(false);
  final notifierImagePizza = ValueNotifier<bool>(false);
  var imagePizza;

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

  void startPizzaBoxAnimation() {
    notifierPizzaboxAnimation.value = true;
    notifierImagePizza.value = true;
  }

  void reset() {
    notifierPizzaboxAnimation.value = false;
    notifierImagePizza.value = false;
    imagePizza = null;
  }

  Future<void> transformToImage(RenderRepaintBoundary boundary) async {
    final position = boundary.localToGlobal(Offset.zero);
    final size = boundary.size;
    final image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    imagePizza = PizzaMetadata(byteData!.buffer.asUint8List(), position, size);
    // notifierImagePizza.value = false;
  }
}
