part of 'widgets.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detail_product_page,
            arguments: product);
      },
      child: Stack(
        children: [
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
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 16,
                          height: 16,
                          child: CircleAvatar(
                            backgroundColor: secondaryColor,
                            child: Icon(
                              Icons.favorite_rounded,
                              size: 8,
                              color: greyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.category,
                    style: hintTextStyle.copyWith(
                      fontSize: 8,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
