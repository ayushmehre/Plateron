import 'package:flutter/cupertino.dart';
import '../models/product_item_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository;

  ProductProvider(this._productRepository);

  List<ProductItem> _products = [];
  List<ProductItem> get products => _products;

  Map<String, List<ProductItem>> _productsByCategory = {};

  Future<void> fetchProducts() async {
    try {
      _products = _productRepository.getProducts();
      _productsByCategory = {};
      for (ProductItem product in _products) {
        if (!_productsByCategory.containsKey(product.category)) {
          _productsByCategory[product.category] = [];
        }
        _productsByCategory[product.category]!.add(product);
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Map<String, List<ProductItem>> get productsByCategory => _productsByCategory;

  List<ProductItem> getCategoryProducts(String categoryName) {
    return _productsByCategory.containsKey(categoryName) ? _productsByCategory[categoryName]! : [];
  }

  bool hasCategory(String categoryName) {
    return _productsByCategory.containsKey(categoryName);
  }
}
