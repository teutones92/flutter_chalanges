import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/models/grocery_products.dart';

class GroceryStoreDetails extends StatelessWidget {
  const GroceryStoreDetails({Key? key, required this.product})
      : super(key: key);
  final GroceryProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'list_${product.name}',
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
