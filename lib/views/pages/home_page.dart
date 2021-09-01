part of 'pages.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _header(UserModel user) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: blackColor1,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            // Profile Picture
            Container(
              width: 52,
              height: 52,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.profilePicture),
                ),
              ),
            ),

            // Name & Balance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: whiteTextStyle1.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    NumberFormat.currency(
                      locale: 'ID',
                      symbol: 'IDR ',
                      decimalDigits: 0,
                    ).format(user.balance),
                    style: orangeTextStyle.copyWith(
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),

            // Cart Icon
            GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.cart,
                color: whiteColor,
                size: 24,
              ),
            ),
          ],
        ),
      );
    }

    Widget _searchField() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  autofocus: false,
                  cursorColor: orangeColor,
                  style: regularTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Find your own hobby',
                    hintStyle: hintTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(width: 24),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: blackColor2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                CupertinoIcons.search,
                color: whiteColor,
                size: 24,
              ),
            ),
          ],
        ),
      );
    }

    Widget _bestSellerProducts() {
      return Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20,
                bottom: 12,
              ),
              child: Text(
                'Best Seller',
                style: titleTextStyle.copyWith(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _categoriesBannner() {
      int index = -1;

      return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: SpinKitWave(
                size: 50,
                color: blackColor2,
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is CategorySuccess) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 12,
                    ),
                    child: Text(
                      'Categories',
                      style: titleTextStyle.copyWith(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.categories.map((category) {
                        index++;
                        return CategoryItem(
                          index: index,
                          itemCount: state.categories.length,
                          category: category,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (_, state) {
        if (state is AuthSuccess) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(state.user),
                _searchField(),
                _bestSellerProducts(),
                _categoriesBannner(),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'Homepage',
              style: regularTextStyle,
            ),
          );
        }
      },
    );
  }
}
