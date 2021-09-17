import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _pizzaCartSize = 48.0;

class PizzaOrderCustome extends StatelessWidget {
  const PizzaOrderCustome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.brown,
        ),
        title: Text(
          'Cuban Pizza Order',
          style: TextStyle(color: Colors.brown, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.brown,
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 60,
            left: 10,
            right: 10,
            top: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: _PizzaDetails(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: _PizzaCartButton(),
          ),
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatelessWidget {
  const _PizzaDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: [
              Image.asset('assets/pizza_order/samples/wooden_plate2.png'),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/pizza_order/samples/pizza1.png')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Precio',
            style: TextStyle(
                color: Colors.brown, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _PizzaCartButton extends StatelessWidget {
  const _PizzaCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange.withOpacity(0.5), Colors.orange],
        ),
      ),
    );
  }
}
