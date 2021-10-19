import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/pizza_order/pizza_order_bloc.dart';

class PizzaOrderAnimation extends StatefulWidget {
  final PizzaMetadata metadata;
  final VoidCallback onComplete;

  const PizzaOrderAnimation(
      {Key? key, required this.metadata, required this.onComplete})
      : super(key: key);

  @override
  _PizzaOrderAnimationState createState() => _PizzaOrderAnimationState();
}

class _PizzaOrderAnimationState extends State<PizzaOrderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metadata = widget.metadata;
    return Positioned(
      top: metadata.position.dy,
      left: metadata.position.dx,
      width: metadata.size.width,
      height: metadata.size.height,
      child: GestureDetector(
        onTap: () {
          widget.onComplete();
        },
        child: Stack(
          children: [
            _buildPizzaBox(),
            Image.memory(widget.metadata.imageBytes),
          ],
        ),
      ),
    );
  }

  Widget _buildPizzaBox() {
    return LayoutBuilder(builder: (context, constrains) {
      return Stack(
        children: [],
      );
    });
  }
}
