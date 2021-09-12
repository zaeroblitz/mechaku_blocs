import '../routes/AppRoutes.dart';
import '../../views/pages/pages.dart';
import 'package:flutter/cupertino.dart';

class AppPages {
  Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.mainpage: (context) => MainPage(),
    AppRoutes.cart_page: (context) => CartPage(),
    AppRoutes.top_up_page: (context) => TopUpPage(),
    AppRoutes.search_page: (context) => SearchPage(),
    AppRoutes.splash_page: (context) => SplashPage(),
    AppRoutes.sign_in_page: (context) => SignInPage(),
    AppRoutes.sign_up_page: (context) => SignUpPage(),
    AppRoutes.category_page: (context) => CategoryPage(),
    AppRoutes.checkout_page: (context) => CheckoutPage(),
    AppRoutes.wishlists_page: (context) => WishlistPage(),
    AppRoutes.success_top_up_page: (context) => SuccessTopUpPage(),
    AppRoutes.detail_product_page: (context) => ProductDetailPage(),
    AppRoutes.success_checkout_page: (context) => SucceeCheckoutPage(),
  };
}
