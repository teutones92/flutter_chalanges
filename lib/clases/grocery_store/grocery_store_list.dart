import 'package:flutter/material.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_provider.dart';
import 'package:flutter_chalanges/clases/grocery_store/grocery_store_details.dart';
import 'package:flutter_chalanges/widgets/staggered_dual_view.dart';

import 'grocery_store_page.dart';

class GrocerySoreList extends StatelessWidget {
  const GrocerySoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)!.bloc;
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: cartBarHeigth, right: 3, left: 3),
      child: StaggeredDualView(
          aspectRatio: 0.7,
          key: key,
          itemPercent: 0.3,
          itemBuilder: (context, index) {
            final product = bloc.catalog[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (context, animation, ___) {
                    return FadeTransition(
                      child: GroceryStoreDetails(product: product),
                      opacity: animation,
                    );
                  }),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'list_${product.name}',
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        product.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      Text(
                        product.weight,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: bloc.catalog.length),
    );
    // return ListView.builder(
    //   padding: const EdgeInsets.only(top: cartBarHeigth),
    //   itemCount: bloc.catalog.length,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.primaries[index % Colors.primaries.length],
    //     );
    //   },
    // );
  }
}
