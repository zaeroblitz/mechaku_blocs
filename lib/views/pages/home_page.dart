part of 'pages.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController queryController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProducts();
    context.read<CategoryCubit>().getCategories(5);
    context.read<ProductBestSellerCubit>().getBestSellerProducts();
    context.read<ProductNewArrivalCubit>().getNewArrivalProducts();
  }

  @override
  Widget build(BuildContext context) {
    Widget _header(UserModel user) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: blackColor1,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 52,
              height: 52,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.profilePicture),
                ),
              ),
            ),

            // Name & Balance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: whiteTextStyle1.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),

                  // User Balance
                  Text(
                    NumberFormat.currency(
                      locale: 'ID',
                      symbol: 'IDR ',
                      decimalDigits: 2,
                    ).format(user.balance),
                    style: orangeTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),

            // Cart Icon
            Container(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.bag,
                        color: whiteColor2,
                        size: 24,
                      ),
                    ),
                  ),
                  (user.checkout.isNotEmpty)
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${user.checkout.length}',
                                style: whiteTextStyle2.copyWith(
                                  fontSize: 10,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _searchField() {
      return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductByName) {
            Navigator.pushNamed(
              context,
              AppRoutes.search_page,
              arguments: state.products,
            );
          } else if (state is ProductFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: pinkColor,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      autofocus: false,
                      controller: queryController,
                      cursorColor: orangeColor,
                      style: regularTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Find your own hobby',
                        hintStyle: hintTextStyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    context
                        .read<ProductCubit>()
                        .getProductsByName(queryController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: blackColor2,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      CupertinoIcons.search,
                      color: whiteColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget _bestSellerProducts(UserModel user) {
      int index = -1;
      return BlocBuilder<ProductBestSellerCubit, ProductBestSellerState>(
        builder: (context, state) {
          if (state is ProductBestSellerLoading) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: SpinKitWave(
                  size: 50,
                  color: blackColor1,
                  duration: Duration(seconds: 3),
                ),
              ),
            );
          } else if (state is ProductBestSellerSuccesss) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Best Seller Title
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 12,
                    ),
                    child: Text(
                      'Best Seller',
                      style: titleTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  // Best Seller Items
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.products.map((product) {
                        index++;
                        return BestSellerItem(
                          product: product,
                          index: index,
                          itemCount: state.products.length,
                          user: user,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            print(state.toString());
            return SizedBox();
          }
        },
      );
    }

    Widget _categoriesBannner() {
      int index = -1;

      return BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: SpinKitWave(
                  size: 50,
                  color: blackColor2,
                  duration: Duration(seconds: 3),
                ),
              ),
            );
          } else if (state is CategorySuccess) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 12,
                    ),
                    child: Text(
                      'Categories',
                      style: titleTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.categories.map((category) {
                        index++;
                        return CategoryItem(
                          index: index,
                          itemCount: state.categories.length,
                          category: category,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }

    Widget _newArrivalProducts(UserModel user) {
      int index = -1;
      return BlocBuilder<ProductNewArrivalCubit, ProductNewArrivalState>(
        builder: (context, state) {
          if (state is ProductNewArrivalLoading) {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: SpinKitWave(
                  size: 50,
                  color: blackColor2,
                  duration: Duration(seconds: 3),
                ),
              ),
            );
          } else if (state is ProductNewArrivalSuccess) {
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Arrival Title
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 12,
                    ),
                    child: Text(
                      'New Arrival',
                      style: titleTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  // New Arrival Items
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.products.map((product) {
                        index++;
                        return NewArrivalItem(
                          product: product,
                          index: index,
                          itemCount: state.products.length,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, userState) {
        if (userState is AuthSuccess) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(userState.user),
                _searchField(),
                _bestSellerProducts(userState.user),
                _categoriesBannner(),
                _newArrivalProducts(userState.user),
                SizedBox(height: 80),
              ],
            ),
          );
        } else if (userState is AuthFailed) {
          return Center(child: Text(userState.error));
        } else {
          return Center(
            child: SpinKitWanderingCubes(
              size: 50,
              color: blackColor2,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }
}
