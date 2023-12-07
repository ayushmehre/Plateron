import 'data.dart';
import 'models/product_item_model.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource._internal();

  ApiDataSource._internal();

  List<ProductItem> fetchProducts() {
    return products.map((json) => ProductItem.fromJson(json)).toList();
  }
}
