import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_provider.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_bloc.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_cart.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_list.dart';

const backgroundColor = Color(0XFFF6F5F2);
const cartBarHeigth = 120.0;
const _panelTransition = Duration(milliseconds: 900);

class GroceryStore extends StatefulWidget {
  const GroceryStore({Key? key}) : super(key: key);

  @override
  _GroceryStoreState createState() => _GroceryStoreState();
}

class _GroceryStoreState extends State<GroceryStore> {
  final bloc = GroceryStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta! > 7) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -cartBarHeigth + kToolbarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeigth / 2);
    } else
      return 0.0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return size.height - cartBarHeigth;
    } else if (state == GroceryState.cart) {
      return cartBarHeigth / 2;
    } else
      return 0.0;
  }

  double _getTopForAppBar(GroceryState state) {
    if (state == GroceryState.normal) {
      return 0.0;
    } else if (state == GroceryState.cart) {
      return -cartBarHeigth;
    } else
      return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
          animation: bloc,
          builder: (context, _) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Stack(
                  children: [
                    //////////////////// Panel Blanco ////////////////////////
                    AnimatedPositioned(
                      duration: _panelTransition,
                      curve: Curves.decelerate,
                      left: 0,
                      right: 0,
                      top: _getTopForWhitePanel(bloc.groceryState, size),
                      height: size.height - kToolbarHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: GrocerySoreList(),
                        ),
                      ),
                    ),
                    ////////////////////////Panel Negro  ///////////////////
                    AnimatedPositioned(
                      duration: _panelTransition,
                      curve: Curves.decelerate,
                      left: 0,
                      right: 0,
                      top: _getTopForBlackPanel(bloc.groceryState, size),
                      height: size.height - kToolbarHeight,
                      child: GestureDetector(
                        onVerticalDragUpdate: _onVerticalGesture,
                        child: Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: AnimatedSwitcher(
                                  duration: _panelTransition,
                                  child: SizedBox(
                                    height: kToolbarHeight,
                                    child: bloc.groceryState ==
                                            GroceryState.normal
                                        ? Row(
                                            children: [
                                              Text(
                                                'Carrito',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: List.generate(
                                                      bloc.cart.length,
                                                      (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: Stack(
                                                          children: [
                                                            Hero(
                                                              tag:
                                                                  'list_${bloc.cart[index].product.name}details',
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundImage:
                                                                    AssetImage(bloc
                                                                        .cart[
                                                                            index]
                                                                        .product
                                                                        .image),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              right: 0,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 10,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                child: Text(
                                                                  bloc
                                                                      .cart[
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.yellow,
                                                child: Text(
                                                  bloc
                                                      .cartTotalElemnts()
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GroceryStoreCart(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: _panelTransition,
                      curve: Curves.decelerate,
                      child: _GroceryStoreAppBar(),
                      top: _getTopForAppBar(bloc.groceryState),
                      left: 0,
                      right: 0,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _GroceryStoreAppBar extends StatelessWidget {
  const _GroceryStoreAppBar({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: kToolbarHeight,
      child: Row(
        children: [
          BackButton(
            color: Colors.black,
          ),
          Expanded(
            child: Text(
              'Frútas y Vegetáles',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
