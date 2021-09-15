import 'package:flutter/material.dart';

class GroceryStore extends StatelessWidget {
  const GroceryStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left),
            ),
            Text('Grocery Store')
          ],
        ),
      ),
    );
  }
}
