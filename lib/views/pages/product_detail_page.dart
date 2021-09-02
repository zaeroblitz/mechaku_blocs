part of 'pages.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

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

    Widget _productGallery() {
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
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Icon
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: blackColor2,
                          size: 20,
                        ),
                      ),
                    ),

                    // Cart Icon
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          CupertinoIcons.cart,
                          color: blackColor2,
                          size: 20,
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

    Widget _productInformation() {
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
            Container(
              margin: EdgeInsets.only(left: 12),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.bookmark,
                size: 24,
                color: greyColor,
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

      Widget _buttons() {
        return Container(
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
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: blackColor2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Add to Cart',
                      textAlign: TextAlign.center,
                      style: whiteTextStyle1.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
            _buttons(),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _productGallery(),
              _productInformation(),
            ],
          ),
        ),
      ),
    );
  }
}
