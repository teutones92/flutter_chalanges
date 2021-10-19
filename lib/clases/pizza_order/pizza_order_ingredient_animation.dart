import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_provider.dart';

late AnimationController animationController;
List<Animation> _animationList = <Animation>[];
late BoxConstraints pizzaContrains;

void buildIngredientsAnimation() {
  _animationList.clear();
  _animationList.add(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(0.0, 0.8, curve: Curves.decelerate),
    ),
  );
  _animationList.add(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(0.2, 0.8, curve: Curves.decelerate),
    ),
  );
  _animationList.add(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(0.4, 1.0, curve: Curves.decelerate),
    ),
  );
  _animationList.add(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(0.1, 0.7, curve: Curves.decelerate),
    ),
  );
  _animationList.add(
    CurvedAnimation(
      parent: animationController,
      curve: Interval(0.3, 1.0, curve: Curves.decelerate),
    ),
  );
}

Widget buildIngredientsWidget(
    Ingredients? deletedIngredient, BuildContext context) {
  List<Widget> elements = [];
  final listIngredients =
      List.from(PizzaOrderProvider.of(context).listIngredients);
  if (deletedIngredient != null) {
    listIngredients.add(deletedIngredient);
  }
  if (_animationList.isNotEmpty) {
    for (int i = 0; i < listIngredients.length; i++) {
      Ingredients ingredient = listIngredients[i];
      final ingredientWidget = Image.asset(ingredient.image, height: 40);
      for (int j = 0; j < ingredient.positions.length; j++) {
        final animation = _animationList[j];
        final position = ingredient.positions[j];
        final positionX = position.dx;
        final positionY = position.dy;
        if (i == listIngredients.length - 1 &&
            animationController.isAnimating) {
          double fromX = 0.0, fromY = 0.0;
          if (j < 1) {
            fromX = -pizzaContrains.maxWidth * (1 - animation.value);
          } else if (j < 2) {
            fromX = -pizzaContrains.maxWidth * (1 - animation.value);
          } else if (j < 4) {
            fromY = -pizzaContrains.maxHeight * (1 - animation.value);
          } else {
            fromY = pizzaContrains.maxHeight * (1 - animation.value);
          }
          final opacity = animation.value;
          if (animation.value > 0) {
            elements.add(
              Opacity(
                opacity: opacity,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(fromX + pizzaContrains.maxWidth * positionX,
                        fromY + pizzaContrains.maxHeight * positionY),
                  child: ingredientWidget,
                ),
              ),
            );
          }
        } else {
          elements.add(
            Transform(
              transform: Matrix4.identity()
                ..translate(pizzaContrains.maxWidth * positionX,
                    pizzaContrains.maxHeight * positionY),
              child: ingredientWidget,
            ),
          );
        }
      }
    }
    return Stack(
      children: elements,
    );
  }
  return SizedBox.fromSize();
}

Future<void> animateDeletedIngredient(
    Ingredients? deletedIngredient, BuildContext context) async {
  if (deletedIngredient != null) {
    await animationController.reverse(from: 1.0);
    final bloc = PizzaOrderProvider.of(context);
    bloc.refreshDeletedIngredient();
  }
}
