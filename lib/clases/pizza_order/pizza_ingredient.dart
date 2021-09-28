import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_provider.dart';

const itemSize = 45.0;

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return ValueListenableBuilder(
        valueListenable: bloc.notifierTotal,
        builder: (context, value, _) {
          // final list = bloc.listIngredients;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return PizzaIngredientsItem(
                  ingredient: ingredient,
                  exist: bloc.containsIngredients(ingredient),
                  onTap: () {
                    bloc.removeIngredients(ingredient);
                    print('delete');
                  },
                );
              });
        });
  }
}

class PizzaIngredientsItem extends StatelessWidget {
  const PizzaIngredientsItem({
    Key? key,
    required this.ingredient,
    required this.exist,
    required this.onTap,
  }) : super(key: key);
  final Ingredients ingredient;
  final bool exist;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: exist
          ? _buildChild()
          : Draggable(
              feedback: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.black26,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: 1.0),
                  ],
                ),
                child: _buildChild(),
              ),
              childWhenDragging: _buildChild(withImage: false),
              data: ingredient,
              child: _buildChild(),
            ),
    );
  }

  Widget _buildChild({bool withImage = true}) {
    return GestureDetector(
      onTap: exist ? onTap : null,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: itemSize,
              width: itemSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5EED3),
                border: exist ? Border.all(color: Colors.red, width: 2) : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  ingredient.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
