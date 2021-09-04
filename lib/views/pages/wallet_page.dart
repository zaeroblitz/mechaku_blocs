part of 'pages.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return CustomHeader(
          headerBanner: AssetImage('assets/wallet_page_banner.png'),
          headerTitle: 'Mechaku Wallet');
    }

    Widget _wallet(UserModel user) {
      return Center(
        child: Column(
          children: [
            // Wallet
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/bumblebee.jpg',
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: blackColor2.withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(4, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background Overlay
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          blackColor2.withOpacity(0.95),
                          blackColor2.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),

                  // User Balance
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 24,
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mechaku Wallet',
                              style: whiteTextStyle2.copyWith(
                                fontSize: 18,
                                fontWeight: bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'ID',
                                symbol: 'IDR ',
                                decimalDigits: 2,
                              ).format(user.balance),
                              style: whiteTextStyle2.copyWith(
                                fontSize: 28,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 30,
                        top: 140,
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 200,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Holder',
                                style: whiteTextStyle2.copyWith(
                                  fontSize: 12,
                                  fontWeight: light,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: whiteTextStyle2.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: orangeColor2,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: whiteColor2,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 36,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card ID',
                                style: whiteTextStyle2.copyWith(
                                  fontSize: 12,
                                  fontWeight: light,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.username,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: whiteTextStyle2.copyWith(
                                      fontSize: 12,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: orangeColor2,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: whiteColor2,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Button
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: CustomButton(
                onPressed: () {},
                text: 'Top Up',
                width: MediaQuery.of(context).size.width - 60,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _header(),
                _wallet(state.user),
                SizedBox(
                  height: 90,
                ),
              ],
            );
          } else {
            return SpinKitWanderingCubes(
              size: 50,
              color: blackColor1,
              duration: Duration(seconds: 3),
            );
          }
        },
      ),
    );
  }
}
