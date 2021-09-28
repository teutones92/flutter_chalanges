import 'package:flutter/material.dart';

class PizzaCartButton extends StatefulWidget {
  const PizzaCartButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  _PizzaCartButtonState createState() => _PizzaCartButtonState();
}

class _PizzaCartButtonState extends State<PizzaCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: const Duration(milliseconds: 150),
      reverseDuration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.withOpacity(0.5),
                Colors.orange,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10.0,
                offset: Offset(0.0, 8.0),
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 35,
          ),
        ),
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
              scale: 2 - _animationController.value, child: child);
        },
      ),
    );
  }
}
