import 'package:flutter/material.dart';
import 'package:plateron/models/cart_item_model.dart';
import 'package:plateron/widgets/add_btn.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clearCart();
            },
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(cartItem: cartItems[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                            height: 1,
                            thickness: 1,
                          ),
                        );
                      }),
                ),
                //sticky footer
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '₹${cartProvider.totalAmount}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        cartItem.product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AddButton(
                        quantity: cartProvider.getQuantity(cartItem.product),
                        onAddPressed: () {
                          cartProvider.addToCart(cartItem.product);
                        },
                        onMinusPressed: () {
                          cartProvider.decreaseQuantity(cartItem.product);
                        }),
                    const SizedBox(height: 10),
                    Text(
                      '₹${cartItem.product.price}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
