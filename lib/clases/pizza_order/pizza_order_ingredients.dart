import 'package:flutter/cupertino.dart';

class Ingredients {
  const Ingredients(
    this.image,
    this.positions,
  );
  final String image;
  final List<Offset> positions;
  bool compare(Ingredients ingredients) => ingredients.image == image;
}

final ingredients = const <Ingredients>[
  Ingredients(
    'assets/pizza_order/ingredients/green_chillies.png',
    <Offset>[
      Offset(0.5, 0.2),
      Offset(0.6, 0.25),
      Offset(0.4, 0.2),
      Offset(0.5, 0.35),
      Offset(0.4, 0.6),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/green_peppers.png',
    <Offset>[
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/halloumi.png',
    <Offset>[
      Offset(0.2, 0.65),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.35),
      Offset(0.4, 0.65),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/mushrooms.png',
    <Offset>[
      Offset(0.5, 0.3),
      Offset(0.65, 0.3),
      Offset(0.35, 0.13),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/olives.png',
    <Offset>[
      Offset(0.2, 0.26),
      Offset(0.35, 0.15),
      Offset(0.7, 0.60),
      Offset(0.2, 0.27),
      Offset(0.3, 0.30),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/onions.png',
    <Offset>[
      Offset(0.6, 0.7),
      Offset(0.2, 0.32),
      Offset(0.7, 0.30),
      Offset(0.4, 0.9),
      Offset(0.3, 0.7),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/pineapples.png',
    <Offset>[
      Offset(0.4, 0.23),
      Offset(0.6, 0.4),
      Offset(0.7, 0.35),
      Offset(0.15, 0.25),
      Offset(0.4, 0.35),
    ],
  ),
  Ingredients(
    'assets/pizza_order/ingredients/tomatos.png',
    <Offset>[
      Offset(0.2, 0.3),
      Offset(0.5, 0.1),
      Offset(0.3, 0.3),
      Offset(0.5, 0.2),
      Offset(0.3, 0.4),
    ],
  ),
];
