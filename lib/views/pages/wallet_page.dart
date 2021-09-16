part of 'pages.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    context.read<TransactionCubit>().getTransaction(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/wallet_page_banner.png'),
        headerTitle: 'Mechaku Wallet',
        onTap: () => context.read<PageCubit>().setPage(0),
      );
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
                    'assets/mechaku_wallet.png',
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
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.top_up_page);
                },
                text: 'Top Up',
                color: orangeColor2,
                width: MediaQuery.of(context).size.width - 60,
              ),
            ),
          ],
        ),
      );
    }

    Widget _recentTransactions(List<TransactionModel> transactions) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Recent Transaction',
                style: mediumTextStyle.copyWith(fontSize: 18),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: transactions.map((transaction) {
                return RecentTransactionItem(transaction);
              }).toList(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, userState) {
          if (userState is AuthSuccess) {
            return BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, transactionState) {
                if (transactionState is TransactionSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _header(),
                        _wallet(userState.user),
                        (transactionState.transactions.isNotEmpty)
                            ? _recentTransactions(transactionState.transactions)
                            : SizedBox(),
                        SizedBox(height: 90),
                      ],
                    ),
                  );
                } else if (transactionState is TransactionFailed) {
                  return Text(transactionState.error);
                } else {
                  return SpinKitWanderingCubes(
                    size: 50,
                    color: blackColor1,
                    duration: Duration(seconds: 3),
                  );
                }
              },
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
