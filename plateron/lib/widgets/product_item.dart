import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_item_model.dart';
import '../providers/cart_provider.dart';
import 'add_btn.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductItem product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        bool isInCart = cartProvider.isProductInCart(product);
        int quantity = isInCart ? cartProvider.getQuantity(product) : 0;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.5),
                        child: const Center(
                          child: Text('No Image'),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            product.isVeg
                                ? 'assets/images/veg.png'
                                : 'assets/images/non_veg.png',
                            width: 20,
                            height: 20,
                            color: product.isVeg ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '₹${product.price}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Spacer(),
                          AddButton(
                              quantity: quantity,
                              onAddPressed: () {
                                cartProvider.addToCart(product);
                              },
                              onMinusPressed: () {
                                cartProvider.decreaseQuantity(product);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile buildListTile(int quantity, CartProvider cartProvider) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(product.description),
      trailing: AddButton(
        quantity: quantity,
        onAddPressed: () {
          cartProvider.addToCart(product);
        },
        onMinusPressed: () {
          cartProvider.decreaseQuantity(product);
        },
      ),
    );
  }
}
