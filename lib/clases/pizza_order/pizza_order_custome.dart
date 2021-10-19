import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_cart_button.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_ingredient.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_bloc.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_sale_animation.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredient_animation.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_ingredients.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_provider.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_price_animation.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_size_button.dart';

const _pizzaCartSize = 60.0;

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
                  bloc.startPizzaBoxAnimation();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  const _PizzaDetails({Key? key}) : super(key: key);

  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with TickerProviderStateMixin {
  late AnimationController _animationRotationController;
  final _keyPizza = GlobalKey();

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _animationRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final bloc = PizzaOrderProvider.of(context);
      bloc.notifierPizzaboxAnimation.addListener(() {
        if (bloc.notifierPizzaboxAnimation.value == true) {
          _addPizzaToCart();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
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
              bloc.notifyFocussed.value = false;
              bloc.addIngredient(ingredient);
              buildIngredientsAnimation();
              animationController.forward(from: 0.0);
            },
            onWillAccept: (ingredient) {
              bloc.notifyFocussed.value = true;
              return !bloc.containsIngredients(ingredient!);
            },
            onLeave: (ingredient) {
              bloc.notifyFocussed.value = false;
            },
            builder: (context, list, reject) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  pizzaContrains = constraints;
                  return ValueListenableBuilder<bool>(
                      valueListenable: bloc.notifierImagePizza,
                      builder: (context, data, child) {
                        if (data == true) {
                          Future.microtask(() {
                            Timer(Duration(milliseconds: 200), () {
                              _startPizzaBoxAnimation(bloc.imagePizza);
                            });
                          });
                        }
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: data == true ? 0.0 : 1,
                          child: ValueListenableBuilder<PizzaSizeState>(
                              valueListenable: bloc.notifierPizzaSize,
                              builder: (context, pizzaSize, _) {
                                return RepaintBoundary(
                                  key: _keyPizza,
                                  child: RotationTransition(
                                    turns: CurvedAnimation(
                                        curve: Curves.elasticOut,
                                        parent: _animationRotationController),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: ValueListenableBuilder<bool>(
                                              valueListenable:
                                                  bloc.notifyFocussed,
                                              builder: (context, _focused, _) {
                                                return AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  height: _focused
                                                      ? constraints.maxHeight *
                                                          pizzaSize.factor
                                                      : constraints.maxHeight *
                                                              pizzaSize.factor -
                                                          10,
                                                  child: Stack(
                                                    children: [
                                                      DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius:
                                                                    10.0,
                                                                color: Colors
                                                                    .black26,
                                                                offset: Offset(
                                                                    0.0, 5.0),
                                                                spreadRadius:
                                                                    5.0)
                                                          ],
                                                        ),
                                                        child: Image.asset(
                                                            'assets/pizza_order/samples/wooden_plate2.png'),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Image.asset(
                                                              'assets/pizza_order/samples/pizza1.png')),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                        ValueListenableBuilder<bool>(
                                          valueListenable:
                                              bloc.notifierDeletedIngredient,
                                          builder: (context, deleted, _) {
                                            if (deleted == true) {
                                              animateDeletedIngredient(
                                                  bloc.deletedIngredient,
                                                  context);
                                            }
                                            return AnimatedBuilder(
                                              animation: animationController,
                                              builder: (context, _) {
                                                return buildIngredientsWidget(
                                                    bloc.deletedIngredient,
                                                    context);
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: priceAnimation(context),
        ),
        ValueListenableBuilder<PizzaSizeState>(
            valueListenable: bloc.notifierPizzaSize,
            builder: (context, pizzaSize, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PizzaSizeButton(
                    text: 'S',
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.s);
                    },
                    selected: pizzaSize.value == PizzaSizeValue.s,
                  ),
                  PizzaSizeButton(
                    text: 'M',
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.m);
                    },
                    selected: pizzaSize.value == PizzaSizeValue.m,
                  ),
                  PizzaSizeButton(
                    text: 'L',
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.l);
                    },
                    selected: pizzaSize.value == PizzaSizeValue.l,
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

  void _updatePizzaSize(PizzaSizeValue value) {
    final bloc = PizzaOrderProvider.of(context);
    bloc.notifierPizzaSize.value = PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
  }

  void _addPizzaToCart() {
    final bloc = PizzaOrderProvider.of(context);
    RenderRepaintBoundary boundary =
        _keyPizza.currentContext!.findRenderObject() as RenderRepaintBoundary;
    bloc.transformToImage(boundary);
  }

  late OverlayEntry _overlayEntry;
  bool _itsOverlay = false;

  void _startPizzaBoxAnimation(PizzaMetadata metadata) {
    _itsOverlay = true;
    final bloc = PizzaOrderProvider.of(context);
    if (_itsOverlay == true) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return PizzaOrderAnimation(
          metadata: metadata,
          onComplete: () {
            _overlayEntry.remove();
            _itsOverlay = false;
            bloc.reset();
          },
        );
      });
      Overlay.of(context)!.insert(_overlayEntry);
    }
  }
}
