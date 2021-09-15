import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_bloc.dart';

const _backgroundColor = Color(0XFFF6F5F2);
const _cartBarHeigth = 120.0;

class GroceryStore extends StatefulWidget {
  const GroceryStore({Key? key}) : super(key: key);

  @override
  _GroceryStoreState createState() => _GroceryStoreState();
}

class _GroceryStoreState extends State<GroceryStore> {
  final bloc = GroceryStoreBloc();

  void _onVerticalGesture(DragUpdateDetails details) {
    print(details.primaryDelta!);
    if (details.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (details.primaryDelta! > 2) {
      bloc.changeToNormal();
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return _cartBarHeigth;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight) + 150.0;
    } else
      return _cartBarHeigth;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.red,
            body: SafeArea(
              child: Column(
                children: [
                  _GroceryStoreAppBar(),
                  //////////////////// Panel Blanco ////////////////////////
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: _getTopForWhitePanel(bloc.groceryState, size),
                          height: size.height - kToolbarHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ////////////////////////Panel Negro  ///////////////////
                        Positioned(
                          left: 0,
                          right: 0,
                          top: size.height - _cartBarHeigth - kToolbarHeight,
                          height: size.height,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
      color: _backgroundColor,
      height: kToolbarHeight,
      child: Row(
        children: [
          BackButton(
            color: Colors.black,
          ),
          Expanded(
            child: Text('Fruits & Vegetables'),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
