import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_page.dart';

class HomePage extends StatelessWidget {
  const HomePage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clases de flutter Desafios',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: ListView(
        children: [
          _crearBotones(context),
        ],
      ),
    );
  }

  Widget _crearBotones(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        child: Row(
          children: [
            Icon(Icons.store_outlined),
            SizedBox(
              width: 20.0,
            ),
            Text('Grocery Store'),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroceryStore()),
          );
        },
      ),
    );
  }
}
