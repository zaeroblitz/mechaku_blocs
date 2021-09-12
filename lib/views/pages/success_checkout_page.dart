part of 'pages.dart';

class SucceeCheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _successCheckoutIllustration() {
      return Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/success_checkout.png'),
          ),
        ),
      );
    }

    Widget _text() {
      return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            Text(
              'You made a transaction',
              style: regularTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Stay at home while we\nprepare your dream mechs',
              style: hintTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget _myWallet() {
      return Container(
        width: 250,
        margin: EdgeInsets.only(bottom: 20),
        child: CustomButton(
          onPressed: () {
            context.read<PageCubit>().setPage(3);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.mainpage, (route) => false);
          },
          text: 'My Wallet',
          color: orangeColor2,
        ),
      );
    }

    Widget _backToHome() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover new mecha? ',
            style: regularTextStyle,
          ),
          GestureDetector(
            onTap: () {
              context.read<PageCubit>().setPage(0);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.mainpage, (route) => false);
            },
            child: Text(
              'Back to Home',
              style: orangeTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _successCheckoutIllustration(),
            _text(),
            _myWallet(),
            _backToHome(),
          ],
        ),
      ),
    );
  }
}
