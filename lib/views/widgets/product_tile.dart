part of 'widgets.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final UserModel user;
  ProductTile(this.product, this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detail_product_page,
            arguments: product);
      },
      child: Stack(
        children: [
          // Product Image
          Align(
            alignment: Alignment.topCenter,
            child: CachedNetworkImage(
              imageUrl: product.gallery[0],
              placeholder: (_, __) => ShimmerItem(width: 156, height: 152),
              imageBuilder: (_, imageProvider) => Container(
                width: 156,
                height: 152,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryFontColor.withOpacity(0.15),
                      blurRadius: 4,
                      offset: Offset(4, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Product Information
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 72,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryFontColor.withOpacity(0.15),
                    blurRadius: 4,
                    offset: Offset(4, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Name
                      Expanded(
                        child: Text(
                          product.name,
                          style: regularTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: semiBold,
                          ),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      // Wishlist Icon
                      GestureDetector(
                        onTap: () {
                          if (user.wishlists.contains(product.id)) {
                            user.wishlists.remove(product.id);
                            context
                                .read<AuthCubit>()
                                .removeFromWishlists(user, product);
                            context.read<AuthCubit>().getCurrentUser(user.id);
                          } else {
                            user.wishlists.add(product.id);
                            context
                                .read<AuthCubit>()
                                .addToWishlists(user, product);
                            context.read<AuthCubit>().getCurrentUser(user.id);
                          }
                        },
                        child: Container(
                          width: 16,
                          height: 16,
                          child: CircleAvatar(
                            backgroundColor: user.wishlists.contains(product.id)
                                ? whiteColor
                                : secondaryColor,
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              color: user.wishlists.contains(product.id)
                                  ? pinkColor
                                  : greyColor,
                              size: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Product Category
                  Text(
                    product.category,
                    style: hintTextStyle.copyWith(
                      fontSize: 8,
                    ),
                  ),

                  // Product Price & Buy Now Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Price
                      Text(
                        NumberFormat.currency(
                          locale: 'ID',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(product.price),
                        style: regularTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      // Buy Now Button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 56,
                          height: 24,
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: orangeColor2,
                          ),
                          child: Text(
                            'Buy Now',
                            style: whiteTextStyle1.copyWith(
                              fontSize: 8,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
