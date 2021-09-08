part of 'pages.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products =
        ModalRoute.of(context)!.settings.arguments as List<ProductModel>;

    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/search_page_banner.png'),
        headerTitle: 'Find Your Mechas',
        onTap: () => Navigator.pop(context),
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
            } else if (state is ProductByName) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  controller: ScrollController(
                    keepScrollOffset: true,
                  ),
                  padding: EdgeInsets.only(bottom: 10),
                  childAspectRatio: (148 / 192),
                  children: products.map((product) {
                    return ProductTile(product, user);
                  }).toList(),
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

    return Scaffold(
      body: (products.isEmpty)
          ? ProductNotFound(onPressed: () => Navigator.pop(context))
          : BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(),
                        _products(state.user),
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
