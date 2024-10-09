class Url {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static const String dummy = '$_baseUrl/login';
  static const String sliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoriesListUrl = '$_baseUrl/CategoryList';
  static const String readProfile = '$_baseUrl/ReadProfile';
  static const String createProfile = '$_baseUrl/CreateProfile';
  static const String cartList = '$_baseUrl/CartList';


  static String productListByRemark(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productListByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productListById(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';


  static String emailVerification(String email) =>
      '$_baseUrl/UserLogin/$email';

  static String otpVerification(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';
}
