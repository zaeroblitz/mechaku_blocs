part of 'pages.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<CartModel> carts =
        ModalRoute.of(context)!.settings.arguments as List<CartModel>;

    int totalQty = 0;
    int totalPrice = 0;
    List<ProductModel> products = [];
    List<SoldProductModel> soldProducts = [];

    carts.map((e) {
      totalQty += e.qty;
      totalPrice += e.totalPrice;
      products.add(e.product);
    }).toList();

    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/search_page_banner.png'),
        headerTitle: 'Checkout Page',
        onTap: () => Navigator.pop(context),
      );
    }

    Widget _listItems() {
      return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: carts.map((cart) {
            return CheckoutItem(cart);
          }).toList(),
        ),
      );
    }

    Widget _address() {
      return Container(
        margin: EdgeInsets.only(
          top: 18,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                'Address Details',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: blackColor2,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.home,
                        color: whiteColor2,
                        size: 16,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: blackColor2,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.location,
                        color: whiteColor2,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: regularTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Mechaku Store',
                          style: regularTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Address',
                          style: regularTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Marsemoon',
                          style: regularTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _paymentSummary() {
      return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: mediumTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),

            // Product Qty
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Quantity',
                  style: hintTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$totalQty Items',
                  style: regularTextStyle,
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),

            // Product Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Price',
                  style: hintTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'ID',
                    symbol: 'IDR ',
                    decimalDigits: 2,
                  ).format(totalPrice),
                  style: regularTextStyle,
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),

            // Shipping Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: hintTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Free',
                  style: regularTextStyle,
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: orangeTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'ID',
                    symbol: 'IDR ',
                    decimalDigits: 2,
                  ).format(totalPrice),
                  style: orangeTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _button(UserModel user) {
      return Center(
        child: Container(
          margin: EdgeInsets.only(
            bottom: 30,
          ),
          child: CustomButton(
            onPressed: () async {
              if (user.balance >= totalPrice) {
                TransactionModel transaction = TransactionModel(
                  date:
                      '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                  time: DateTime.now(),
                  title: 'Buy Product',
                  userID: user.id,
                  amount: totalPrice,
                  picture: carts.first.product.gallery[0],
                  transactionID: randomAlphaNumeric(20),
                );

                context.read<TransactionCubit>().setTransaction(transaction);
                context.read<SoldProductCubit>().addSoldProduct(soldProducts);

                user.cart.clear();
                user.balance = user.balance - totalPrice;
                context.read<AuthCubit>().updateuser(user);

                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.success_checkout_page, (route) => false);
              }
            },
            text: 'Checkout Now',
            color: orangeColor2,
            width: MediaQuery.of(context).size.width - 80,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  _listItems(),
                  _address(),
                  _paymentSummary(),
                  _button(state.user),
                ],
              ),
            );
          } else if (state is AuthFailed) {
            return Center(child: Text(state.error));
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
}
