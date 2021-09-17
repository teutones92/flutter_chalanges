import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_provider.dart';

import 'grocery_store_details.dart';

class GroceryStoreCart extends StatelessWidget {
  const GroceryStoreCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)!.bloc;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Carrito',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloc.cart.length,
                    itemBuilder: (context, index) {
                      final item = bloc.cart[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(item.product.image),
                            ),
                            SizedBox(width: 15),
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '*',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 15),
                            Text(
                              item.product.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Spacer(),
                            Text(
                              '\$ ${item.product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                bloc.deleteProduct(item);
                              },
                              icon: Icon(Icons.delete),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 35.0),
              ),
              Spacer(),
              Text(
                '\$ ${bloc.cartTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Siguiente',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              style: elevatedButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
