part of 'pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3),
      () {
        fetchData();
      },
    );
  }

  void fetchData() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.sign_in_page, (route) => false);
    } else {
      context.read<AuthCubit>().getCurrentUser(user.uid);
      context.read<CategoryCubit>().getCategories(5);
      // context.read<ProductCubit>().getProducts();
      context.read<ProductCubit>().getBestSellerProducts();
      // context.read<ProductCubit>().getNewArrivalProducts();

      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.mainpage, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          'assets/logo_full.png',
          width: 350,
        ),
      ),
    );
  }
}
