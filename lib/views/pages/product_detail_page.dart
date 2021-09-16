part of 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProductsByLimit(5);
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    _handleAddToCheckout(UserModel user) {
      CartModel checkout = CartModel(
        product: product,
        qty: 1,
        totalPrice: product.price,
      );
      context.read<AuthCubit>().addToCart(user, checkout);
      context.read<AuthCubit>().getCurrentUser(user.id);
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            'Successfully Added to checkout',
            '${product.name} added to your checkout',
            'Close',
            () => Navigator.pop(context),
          );
        },
      );
    }

    Widget _indicator(int index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: (index == currentIndex) ? 16 : 4,
        height: 4,
        decoration: BoxDecoration(
          color: (index == currentIndex) ? orangeColor : greyColor,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget _productGallery(UserModel user) {
      int index = -1;

      return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Product Gallery
            CarouselSlider(
              items: product.gallery.map((gallery) {
                return CachedNetworkImage(
                  imageUrl: gallery,
                  placeholder: (_, __) {
                    return ShimmerItem(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                    );
                  },
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1.0,
                onPageChanged: (index, _) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),

            // Back Icon & Cart Icon
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Icon
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: blackColor2,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    // Cart Icon
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.cart_page,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 32,
                          height: 32,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor2,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    CupertinoIcons.bag,
                                    color: blackColor2,
                                    size: 20,
                                  ),
                                ),
                              ),
                              (user.cart.isNotEmpty)
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
                                            '${user.cart.length}',
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
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Indicator
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: product.gallery.map((e) {
                    index++;
                    return _indicator(index);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _productInformation(UserModel user) {
      Widget _productInformationHeader() {
        return Row(
          children: [
            // Product Name, Grade, Category
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: titleTextStyle.copyWith(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.grade,
                    style: hintTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    product.category,
                    style: hintTextStyle,
                  ),
                ],
              ),
            ),

            // Bookmark Icon
            GestureDetector(
              onTap: () {
                if (user.wishlists.contains(product.id)) {
                  user.wishlists.remove(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: pinkColor,
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                        'Successfully remove ${product.name} from your wishlists',
                      ),
                    ),
                  );
                  context.read<AuthCubit>().removeFromWishlists(user, product);
                  context.read<AuthCubit>().getCurrentUser(user.id);
                } else {
                  user.wishlists.add(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: greenColor,
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                          'Successfully added ${product.name} to your wishlists'),
                    ),
                  );
                  context.read<AuthCubit>().addToWishlists(user, product);
                  context.read<AuthCubit>().getCurrentUser(user.id);
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: user.wishlists.contains(product.id)
                      ? pinkColor
                      : secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: user.wishlists.contains(product.id)
                      ? whiteColor
                      : greyColor,
                  size: 24,
                ),
              ),
            ),
          ],
        );
      }

      Widget _productPrice() {
        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.35),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            NumberFormat.currency(
              locale: 'ID',
              symbol: 'IDR ',
            ).format(product.price),
            style: orangeTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
        );
      }

      Widget _productStock() {
        return Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            'Available Stock: ${product.qty}',
            style: hintTextStyle.copyWith(
              color: greyColor,
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        );
      }

      Widget _productDescription() {
        return Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Description',
                  style: mediumTextStyle,
                ),
              ),
              Text(
                product.description,
                style: regularTextStyle.copyWith(
                  fontWeight: light,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        );
      }

      Widget _recommendationProducts() {
        int index = -1;
        return BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductByLimit) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Recommendation Products',
                        style: mediumTextStyle,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.products.map((product) {
                          index++;
                          return SuggestedProduct(
                            product,
                            index,
                            state.products.length,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProductLoading) {
              return SpinKitWanderingCubes(
                size: 50,
                color: blackColor1,
                duration: Duration(seconds: 3),
              );
            } else {
              return SizedBox();
            }
          },
        );
      }

      Widget _buttons(UserModel user) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                // Chat Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 24),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: Color(0xFFC4C4C4),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      CupertinoIcons.chat_bubble_text_fill,
                      color: blackColor2,
                      size: 24,
                    ),
                  ),
                ),

                // Add to Cart Button
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      _handleAddToCheckout(user);
                    },
                    text: 'Add to Cart',
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 380),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor2,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productInformationHeader(),
            _productPrice(),
            _productStock(),
            _productDescription(),
            _recommendationProducts(),
            _buttons(user),
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  _productGallery(state.user),
                  _productInformation(state.user),
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
