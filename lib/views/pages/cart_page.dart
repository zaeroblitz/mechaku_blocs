part of 'pages.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return CustomHeader(
          headerBanner: AssetImage('assets/cart_page_banner.png'),
          headerTitle: 'Checkout Page',
          onTap: () => Navigator.pop(context));
    }

    Widget _checkoutList(List<CartModel> cart, UserModel user) {
      int index = 0;

      return (cart.isNotEmpty)
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cart.map((e) {
                    index++;
                    return CartItem(
                        cart: e,
                        user: user,
                        currentIndex: index,
                        itemCount: cart.length);
                  }).toList()),
            )
          : ProductNotFound(onPressed: () => Navigator.pop(context));
    }

    Widget _totalPrice(List<CartModel> cart) {
      int totalPrice = 0;
      cart.map((e) => totalPrice += e.totalPrice).toList();

      return cart.isNotEmpty
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: mediumTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'ID',
                        symbol: 'IDR ',
                        decimalDigits: 2,
                      ).format(totalPrice),
                      style: orangeTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox();
    }

    Widget _button(List<CartModel> cart) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: CustomButton(
          onPressed: () => Navigator.pushNamed(
            context,
            AppRoutes.checkout_page,
            arguments: cart,
          ),
          text: 'Add to Checkout',
          color: orangeColor2,
        ),
      );
    }

    Widget _bottomNav(List<CartModel> cart) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _totalPrice(cart),
            _button(cart),
          ],
        ),
      );
    }

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
            backgroundColor: bgColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  _checkoutList(state.user.cart, state.user),
                ],
              ),
            ),
            bottomNavigationBar: _bottomNav(state.user.cart),
          );
        } else if (state is AuthFailed) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else {
          return Scaffold(
            body: SpinKitWanderingCubes(
              size: 50,
              color: blackColor2,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }
}
