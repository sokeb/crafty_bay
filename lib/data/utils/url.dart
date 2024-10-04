class Url {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static const String dummy = '$_baseUrl/login';
  static const String sliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoriesListUrl = '$_baseUrl/CategoryList';

  static String productListByRemark(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productListByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productListById(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';
}
