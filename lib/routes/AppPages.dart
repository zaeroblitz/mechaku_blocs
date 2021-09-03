import '../routes/AppRoutes.dart';
import '../../views/pages/pages.dart';
import 'package:flutter/cupertino.dart';

class AppPages {
  Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.mainpage: (context) => MainPage(),
    AppRoutes.search_page: (context) => SearchPage(),
    AppRoutes.splash_page: (context) => SplashPage(),
    AppRoutes.sign_in_page: (context) => SignInPage(),
    AppRoutes.sign_up_page: (context) => SignUpPage(),
    AppRoutes.category_page: (context) => CategoryPage(),
    AppRoutes.detail_product_page: (context) => ProductDetailPage(),
  };
}
