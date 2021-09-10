part of 'widgets.dart';

class CheckoutItem extends StatelessWidget {
  final CartModel cart;

  CheckoutItem(this.cart);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(cart.product.gallery[0]),
              ),
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
                SizedBox(height: 2),
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

          // Product Qty
          Text(
            '${cart.qty} items',
            style: hintTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
