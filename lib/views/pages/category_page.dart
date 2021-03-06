part of 'pages.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryModel category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    Widget _header() {
      return CachedNetworkImage(
        imageUrl: category.banner,
        placeholder: (_, __) => ShimmerItem(
            width: MediaQuery.of(context).size.width - 20, height: 90),
        imageBuilder: (_, imageProvider) => Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 90,
          margin: EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      blackColor1.withOpacity(0.95),
                      blackColor1.withOpacity(0.25),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: whiteColor2,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            size: 24,
                            color: blackColor2,
                          ),
                        ),
                      ),
                      Text(
                        category.name + 'Products',
                        style: whiteTextStyle1.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _products(UserModel user) {
      return BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: SpinKitWanderingCubes(
                size: 50,
                color: blackColor2,
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is ProductByCategory) {
            if (state.products.isEmpty) {
              return ProductNotFound(
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else {
              return Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  controller: ScrollController(
                    keepScrollOffset: true,
                  ),
                  childAspectRatio: (148 / 192),
                  children: state.products.map((product) {
                    return ProductTile(product, user);
                  }).toList(),
                ),
              );
            }
          } else {
            return SpinKitWanderingCubes(
              size: 50,
              color: blackColor2,
              duration: Duration(seconds: 3),
            );
          }
        },
      );
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
