part of 'widgets.dart';

class BestSellerItem extends StatelessWidget {
  final int index;
  final int itemCount;
  final ProductModel product;

  BestSellerItem(
      {required this.product, required this.index, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 348,
      margin: EdgeInsets.only(
        left: (index == 0) ? 20 : 16,
        right: (index == itemCount - 1) ? 20 : 0,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CachedNetworkImage(
          imageUrl: product.gallery[0],
          placeholder: (_, __) => ShimmerItem(width: 220, height: 348),
          errorWidget: (_, __, ___) => Container(),
          imageBuilder: (_, imageProvider) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image & Bookmark Icon
                Container(
                  width: 200,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: (Stack(
                    children: [
                      // Product Image
                      Container(
                        width: 200,
                        height: 240,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      // Bookmark Icon
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 8,
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.bookmark,
                                color: primaryFontColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),

                // Product Name & Category
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: regularTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: medium,
                                color: blackColor1,
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                        ],
                      ),

                      // Product Category
                      Text(
                        product.category,
                        style: hintTextStyle.copyWith(
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Price
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    NumberFormat.currency(
                      locale: 'ID',
                      symbol: 'IDR ',
                      decimalDigits: 2,
                    ).format(product.price),
                    style: orangeTextStyle.copyWith(
                      fontSize: 18,
                      color: orangeColor2,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
