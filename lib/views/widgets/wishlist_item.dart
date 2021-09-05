part of 'widgets.dart';

class WishlistItem extends StatelessWidget {
  final UserModel user;
  final ProductModel product;

  WishlistItem(this.user, this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryFontColor.withOpacity(0.15),
            blurRadius: 4,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: product.gallery[0],
        placeholder: (context, url) => ShimmerItem(
          width: MediaQuery.of(context).size.width - 20,
          height: 86,
        ),
        imageBuilder: (context, imageProvider) => Row(
          children: [
            // Product Image
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            // Product Name & Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: regularTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),

                  // Product Price
                  Text(
                    NumberFormat.currency(
                      locale: 'ID',
                      symbol: 'IDR ',
                      decimalDigits: 2,
                    ).format(product.price),
                    style: orangeTextStyle,
                  ),
                ],
              ),
            ),

            // Wishlist Icon
            GestureDetector(
              onTap: () {
                if (user.wishlists.contains(product.id)) {
                  user.wishlists.remove(product.id);
                  context.read<AuthCubit>().removeFromWishlists(user, product);
                  context.read<AuthCubit>().getCurrentUser(user.id);
                } else {
                  user.wishlists.add(product.id);
                  context.read<AuthCubit>().addToWishlists(user, product);
                  context.read<AuthCubit>().getCurrentUser(user.id);
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Container(
                  padding: EdgeInsets.all(8),
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
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
