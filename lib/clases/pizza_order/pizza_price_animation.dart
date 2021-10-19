import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_provider.dart';

Widget priceAnimation(BuildContext context) {
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
