import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';

/////// minuto 30:45 del video de flutter challenge /////

const _pizzaCartSize = 60.0;

class PizzaOrderCustome extends StatelessWidget {
  const PizzaOrderCustome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.brown,
        ),
        title: Text(
          'Cuban Pizza Order',
          style: TextStyle(color: Colors.brown, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.brown,
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 60,
            left: 10,
            right: 10,
            top: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: _PizzaDetails(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _PizzaIngredients(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: _PizzaCartButton(),
          ),
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatelessWidget {
  const _PizzaDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
            child: DragTarget<Ingredients>(
          onAccept: (ingredient) {
            print('acept');
          },
          // onWillAccept: (ingredient) {
          //   print('onWillAcept');
          // },
          onLeave: (ingredient) {
            print('onleave');
          },
          builder: (context, list, reject) {
            return Stack(
              children: [
                Image.asset('assets/pizza_order/samples/wooden_plate2.png'),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:
                        Image.asset('assets/pizza_order/samples/pizza1.png')),
              ],
            );
          },
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Precio',
            style: TextStyle(
                color: Colors.brown, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'ingredientes',
            style: TextStyle(
                color: Colors.brown,
                fontSize: 10,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

class _PizzaCartButton extends StatelessWidget {
  const _PizzaCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange.withOpacity(0.5), Colors.orange],
        ),
      ),
      child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}

class _PizzaIngredients extends StatelessWidget {
  const _PizzaIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return _PizzaIngredientsItem(
            ingredient: ingredient,
          );
        });
  }
}

class _PizzaIngredientsItem extends StatelessWidget {
  final Ingredients ingredient;
  const _PizzaIngredientsItem({Key? key, required this.ingredient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5EED3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            ingredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
    return Draggable(feedback: child, data: ingredient, child: child);
  }
}
