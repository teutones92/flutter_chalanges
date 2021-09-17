import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_provider.dart';

import 'grocery_store_details.dart';

class GroceryStoreCart extends StatelessWidget {
  const GroceryStoreCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)!.bloc;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cart',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0),
                ),
              ],
            ),
          ),
        ),
        Placeholder(),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Siguiente',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          style: elevatedButtonStyle,
        ),
      ],
    );
  }
}
