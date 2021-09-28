import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_cart_button.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_ingredient.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_bloc.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_provider.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_size_button.dart';

const _pizzaCartSize = 60.0;

List<Animation> _animationList = <Animation>[];

class PizzaOrderCustome extends StatefulWidget {
  const PizzaOrderCustome({Key? key}) : super(key: key);

  @override
  _PizzaOrderCustomeState createState() => _PizzaOrderCustomeState();
}

class _PizzaOrderCustomeState extends State<PizzaOrderCustome> {
  final bloc = PizzaOrderBloc();

  Widget build(BuildContext context) {
    return PizzaOrderProvider(
      bloc: bloc,
      child: Scaffold(
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
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: _PizzaDetails(),
                    ),
                    Expanded(
                      flex: 2,
                      child: PizzaIngredients(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              height: _pizzaCartSize,
              width: _pizzaCartSize,
              left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
              child: PizzaCartButton(
                onTap: () {
                  print('cart');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PizzaSizeValue {
  s,
  m,
  l,
}

class _PizzaSizeState {
  _PizzaSizeState(this.value) : factor = getFactorBySize(value);
  final _PizzaSizeValue value;
  final double factor;

  static double getFactorBySize(_PizzaSizeValue value) {
    switch (value) {
      case _PizzaSizeValue.s:
        return 0.75;
      case _PizzaSizeValue.m:
        return 0.85;
      case _PizzaSizeValue.l:
        return 1.0;
    }
  }
}

class _PizzaDetails extends StatefulWidget {
  const _PizzaDetails({Key? key}) : super(key: key);

  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with TickerProviderStateMixin {
  final _notifyFocussed = ValueNotifier(false);
  late AnimationController _animationController;
  late AnimationController _animationRotationController;
  late BoxConstraints _pizzaContrains;
  final _notifierPizzaSize =
      ValueNotifier<_PizzaSizeState>(_PizzaSizeState(_PizzaSizeValue.m));

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.7, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.decelerate),
      ),
    );
  }

  Widget _buildIngredientsWidget(Ingredients? deletedIngredient) {
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
              _animationController.isAnimating) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -_pizzaContrains.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = -_pizzaContrains.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaContrains.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaContrains.maxHeight * (1 - animation.value);
            }
            final opacity = animation.value;
            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(fromX + _pizzaContrains.maxWidth * positionX,
                          fromY + _pizzaContrains.maxHeight * positionY),
                    child: ingredientWidget,
                  ),
                ),
              );
            }
          } else {
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(_pizzaContrains.maxWidth * positionX,
                      _pizzaContrains.maxHeight * positionY),
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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _animationRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = PizzaOrderProvider.of(context);
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: DragTarget<Ingredients>(
            onAccept: (ingredient) {
              _notifyFocussed.value = false;
              bloc.addIngredient(ingredient);
              _buildIngredientsAnimation();
              _animationController.forward(from: 0.0);
            },
            onWillAccept: (ingredient) {
              _notifyFocussed.value = true;
              return !bloc.containsIngredients(ingredient!);
            },
            onLeave: (ingredient) {
              _notifyFocussed.value = false;
            },
            builder: (context, list, reject) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  _pizzaContrains = constraints;
                  return ValueListenableBuilder<_PizzaSizeState>(
                      valueListenable: _notifierPizzaSize,
                      builder: (context, pizzaSize, _) {
                        return RotationTransition(
                          turns: CurvedAnimation(
                              curve: Curves.elasticOut,
                              parent: _animationRotationController),
                          child: Stack(
                            children: [
                              Center(
                                child: ValueListenableBuilder<bool>(
                                    valueListenable: _notifyFocussed,
                                    builder: (context, _focused, _) {
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        height: _focused
                                            ? constraints.maxHeight *
                                                pizzaSize.factor
                                            : constraints.maxHeight *
                                                    pizzaSize.factor -
                                                10,
                                        child: Stack(
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 10.0,
                                                      color: Colors.black26,
                                                      offset: Offset(0.0, 5.0),
                                                      spreadRadius: 5.0)
                                                ],
                                              ),
                                              child: Image.asset(
                                                  'assets/pizza_order/samples/wooden_plate2.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Image.asset(
                                                    'assets/pizza_order/samples/pizza1.png')),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: bloc.notifierDeletedIngredient,
                                builder: (context, deletedIngredient, _) {
                                  _animateDeletedIngredient(
                                      bloc.deletedIngredient);
                                  return AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, _) {
                                      return _buildIngredientsWidget(
                                          bloc.deletedIngredient);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: _priceAnimation(context),
        ),
        ValueListenableBuilder<_PizzaSizeState>(
            valueListenable: _notifierPizzaSize,
            builder: (context, pizzaSize, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PizzaSizeButton(
                    text: 'S',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.s);
                    },
                    selected: pizzaSize.value == _PizzaSizeValue.s,
                  ),
                  PizzaSizeButton(
                    text: 'M',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.m);
                    },
                    selected: pizzaSize.value == _PizzaSizeValue.m,
                  ),
                  PizzaSizeButton(
                    text: 'L',
                    onTap: () {
                      _updatePizzaSize(_PizzaSizeValue.l);
                    },
                    selected: pizzaSize.value == _PizzaSizeValue.l,
                  ),
                ],
              );
            }),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'ingredientes',
          style: TextStyle(
              color: Colors.brown, fontSize: 10, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Future<void> _animateDeletedIngredient(Ingredients? deletedIngredient) async {
    if (deletedIngredient != null) {
      await _animationController.reverse(from: 1.0);
      final bloc = PizzaOrderProvider.of(context);
      bloc.refreshDeletedIngredient();
    }
  }

  void _updatePizzaSize(_PizzaSizeValue value) {
    _notifierPizzaSize.value = _PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }
}

Widget _priceAnimation(BuildContext context) {
  final bloc = PizzaOrderProvider.of(context);
  return ValueListenableBuilder<int>(
      valueListenable: bloc.notifierTotal,
      builder: (context, totalValue, _) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: Offset(0.0, 0.0),
                    end: Offset(
                      0.0,
                      animation.value,
                    ),
                  ),
                ),
                child: child,
              ),
            );
          },
          child: Text(
            '\$$totalValue',
            key: UniqueKey(),
            style: TextStyle(
                color: Colors.brown, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        );
      });
}
