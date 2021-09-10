part of 'widgets.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  final UserModel user;
  final int currentIndex;
  final int itemCount;
  CartItem({
    required this.cart,
    required this.user,
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: currentIndex == itemCount ? 30 : 20,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryFontColor.withOpacity(0.15),
            blurRadius: 4,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Product Image
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: cart.product.gallery[0],
                  placeholder: (_, __) => ShimmerItem(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 110,
                  ),
                  imageBuilder: (_, imageProvider) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              ),

              // Product Name & Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: regularTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'ID',
                        symbol: 'IDR ',
                        decimalDigits: 2,
                      ).format(cart.product.price),
                      style: orangeTextStyle,
                    ),
                  ],
                ),
              ),

              // Increment & Decrement
              Column(
                children: [
                  // Increment
                  GestureDetector(
                    onTap: () {
                      cart.qty++;
                      cart.totalPrice = cart.product.price * cart.qty;
                      context.read<AuthCubit>().updateCartQty(user, user.cart);
                      context.read<AuthCubit>().getCurrentUser(user.id);
                    },
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: orangeColor2,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: whiteColor2,
                          size: 8,
                        ),
                      ),
                    ),
                  ),

                  // Qty
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      cart.qty.toString(),
                      style: regularTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),

                  // Decrement
                  GestureDetector(
                    onTap: () {
                      if (cart.qty == 0) {
                        context.read<AuthCubit>().removeFromCart(user, cart);
                      }

                      cart.qty--;
                      cart.totalPrice = cart.product.price * cart.qty;
                      context.read<AuthCubit>().updateCartQty(user, user.cart);
                      context.read<AuthCubit>().getCurrentUser(user.id);
                    },
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: blackColor1,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: whiteColor2,
                          size: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Remove Icon
          GestureDetector(
            onTap: () {
              context.read<AuthCubit>().removeFromCart(user, cart);
              context.read<AuthCubit>().getCurrentUser(user.id);
            },
            child: Container(
              margin: EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.delete_forever_rounded,
                    color: pinkColor,
                    size: 12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Remove',
                    style: pinkTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
