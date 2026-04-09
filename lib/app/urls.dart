class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String verifyOtp = '$_baseUrl/auth/verify-otp';
  static const String logInUrl = '$_baseUrl/auth/login';

  static const String homeSlidersUrl = '$_baseUrl/slides';
  static const String addToCartUrl = '$_baseUrl/cart';
  static const String getCartListUrl = '$_baseUrl/cart';
  static const String getWishListUrl = '$_baseUrl/wishlist';



  static String categoryListUrl(int pageNO, int pageSize) =>
      '$_baseUrl/categories?count=$pageSize&page=$pageNO';

  static String productListUrl(int pageNO, int pageSize, String categoryId) =>
      '$_baseUrl/products?count=$pageSize&page=$pageNO&category=$categoryId';
  static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';


}
