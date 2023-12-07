import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../routes.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              offset: Offset(-1, -1),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Row(
            children: [
              const Icon(
                Icons.shopping_cart,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                '${cartProvider.getTotalQuantity()} items',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              const SizedBox(
                width: 16.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.orderSummary);
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Place Order',
                      style:
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
