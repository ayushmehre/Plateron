import '../api_data_source.dart';
import '../models/product_item_model.dart';

class ProductRepository {
  ProductRepository();

  List<ProductItem> getProducts() {
    return ApiDataSource.instance.fetchProducts();
  }
}
