import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_page.dart';
import 'package:flutter_chalanges/clases/grocery_store/models/grocery_products.dart';

class GroceryStoreDetails extends StatelessWidget {
  const GroceryStoreDetails({Key? key, required this.product})
      : super(key: key);
  final GroceryProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'list_${product.name}',
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
                color: Colors.black,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Agregar al Carrito',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
