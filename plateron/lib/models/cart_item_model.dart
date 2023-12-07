import 'dart:math';

import 'package:plateron/models/product_item_model.dart';

class CartItem {
  final ProductItem product;
  int quantity;
  int id = Random().nextInt(10000);

  CartItem({required this.product, this.quantity = 1});
}
