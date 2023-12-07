import 'package:flutter/material.dart';
import 'package:plateron/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_widget.dart';
import '../widgets/product_item.dart';

class MenuListingScreen extends StatefulWidget {
  const MenuListingScreen({super.key});

  @override
  State<MenuListingScreen> createState() => _MenuListingScreenState();
}

class _MenuListingScreenState extends State<MenuListingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Listing'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.productsByCategory.length,
                  itemBuilder: (context, index) {
                    final categoryName =
                        provider.productsByCategory.keys.elementAt(index);
                    final products = provider.productsByCategory[categoryName]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category header
                        Container(
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            categoryName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        // List of product items for this category
                        ListView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, innerIndex) {
                            return ProductItemWidget(
                              product: products[innerIndex],
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const CartWidget(),
        ],
      ),
    );
  }
}
