part of 'pages.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products =
        ModalRoute.of(context)!.settings.arguments as List<ProductModel>;

    Widget _header() {
      return Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 90,
        margin: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/search_page_banner.png',
            ),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    blackColor1.withOpacity(0.95),
                    blackColor1.withOpacity(0.25),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: whiteColor2,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          size: 24,
                          color: blackColor2,
                        ),
                      ),
                    ),
                    Text(
                      'Find Your Mechas',
                      style: whiteTextStyle1.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
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

    Widget _products() {
      return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: SpinKitWanderingCubes(
                  size: 50,
                  color: blackColor2,
                  duration: Duration(seconds: 3),
                ),
              );
            } else if (state is ProductByName) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10),
                  childAspectRatio: (148 / 192),
                  children: products.map((product) {
                    return ProductTile(product);
                  }).toList(),
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

    return Scaffold(
      body: (products.isEmpty)
          ? ProductNotFound()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  _products(),
                ],
              ),
            ),
    );
  }
}
