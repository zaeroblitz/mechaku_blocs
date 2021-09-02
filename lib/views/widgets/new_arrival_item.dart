part of 'widgets.dart';

class NewArrivalItem extends StatelessWidget {
  final int index;
  final int itemCount;
  final ProductModel product;

  NewArrivalItem(
      {required this.product, required this.index, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 16,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(18),
      ),
      child: CachedNetworkImage(
          imageUrl: product.gallery[0],
          placeholder: (_, __) => ShimmerItem(
                width: MediaQuery.of(context).size.width - 40,
                height: 140,
              ),
          errorWidget: (context, url, error) => Container(),
          imageBuilder: (context, imageProvider) {
            return Row(
              children: [
                // Product Image
                Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Category
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          product.category,
                          style: hintTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: light,
                          ),
                        ),
                      ),

                      // Product Name
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: titleTextStyle.copyWith(fontSize: 16),
                        ),
                      ),

                      // Product Price
                      Text(
                        NumberFormat.currency(
                          locale: 'ID',
                          symbol: 'IDR ',
                          decimalDigits: 2,
                        ).format(product.price),
                        style: orangeTextStyle.copyWith(
                          color: orangeColor2,
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
