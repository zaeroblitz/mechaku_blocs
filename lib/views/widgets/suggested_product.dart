part of 'widgets.dart';

class SuggestedProduct extends StatelessWidget {
  final ProductModel product;
  final int currentIndex;
  final int itemCount;

  SuggestedProduct(this.product, this.currentIndex, this.itemCount);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detail_product_page,
          arguments: product,
        );
      },
      child: Container(
        width: 64,
        height: 64,
        margin: EdgeInsets.only(
          left: 0,
          right: (currentIndex == itemCount) ? 20 : 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          imageUrl: product.gallery[0],
          placeholder: (context, url) => ShimmerItem(width: 64, height: 64),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
