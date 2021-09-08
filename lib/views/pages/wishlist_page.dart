part of 'pages.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/wishlists_banner.png'),
        headerTitle: 'Your Wishlists',
        onTap: () => context.read<PageCubit>().setPage(0),
      );
    }

    Widget _products(UserModel user) {
      return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: SpinKitWanderingCubes(
                  size: 50,
                  color: blackColor2,
                  duration: Duration(seconds: 3),
                ),
              );
            } else if (state is ProductSuccess) {
              List<ProductModel> products = state.products
                  .where((element) => user.wishlists.contains(element.id))
                  .toList();

              return Column(
                children: products.map((product) {
                  return WishlistItem(user, product);
                }).toList(),
              );
            } else {
              return SpinKitWanderingCubes(
                size: 50,
                color: blackColor2,
                duration: Duration(seconds: 3),
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  (state.user.wishlists.isEmpty)
                      ? ProductNotFound(
                          onPressed: () => context.read<PageCubit>().setPage(0))
                      : _products(state.user),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            );
          } else {
            return SpinKitWanderingCubes(
              size: 50,
              color: blackColor2,
              duration: Duration(seconds: 3),
            );
          }
        },
      ),
    );
  }
}
