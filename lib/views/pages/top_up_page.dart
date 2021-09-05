part of 'pages.dart';

class TopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _amountController = TextEditingController(text: '');

    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/transformers.png'),
        headerTitle: 'Top Up',
      );
    }

    Widget _customAmout() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextField(
          label: 'Custom Amount',
          hintText: 'Fill your custom amount',
          validator: requiredValidator,
          controller: _amountController,
          prefixIconUrl: 'assets/username_icon.png',
        ),
      );
    }

    Widget _templateAmount() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose by template',
              style: mediumTextStyle,
            ),
            Container(
              child: AmounTemplate(),
            ),
          ],
        ),
      );
    }

    Widget _button() {
      return Center(
        child: CustomButton(
          width: MediaQuery.of(context).size.width - 80,
          onPressed: () {},
          text: 'Top Up Now',
          color: orangeColor2,
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _customAmout(),
            _templateAmount(),
            _button(),
          ],
        ),
      ),
    );
  }
}
