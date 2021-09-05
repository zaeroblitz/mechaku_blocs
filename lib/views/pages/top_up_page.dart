part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController(text: '');
  int selectedAmount = 0;
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return CustomHeader(
        headerBanner: AssetImage('assets/transformers.png'),
        headerTitle: 'Top Up',
      );
    }

    Widget _customAmout() {
      Widget _topUpTextField() {
        return Form(
          key: _key,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label Text
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Custom Amount',
                    style: mediumTextStyle,
                  ),
                ),

                // Text Field
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Prefix
                      Container(
                        width: 18,
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(
                          CupertinoIcons.creditcard,
                        ),
                      ),

                      // TextField
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          controller: _amountController,
                          style: regularTextStyle,
                          validator: PatternValidator('^[1-9][0-9]',
                              errorText: 'Must be number & greater than 0'),
                          cursorColor: orangeColor,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Fill your custom amount',
                            hintStyle: hintTextStyle,
                          ),
                          onChanged: (value) {
                            if (value != '') {
                              setState(() {
                                isEmpty = false;
                              });
                            } else if (value == '') {
                              setState(() {
                                isEmpty = true;
                              });
                            }
                          },
                        ),
                      ),

                      // Suffix
                      isEmpty
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmpty = true;
                                  _amountController.text = '';
                                });
                              },
                              child: Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: blackColor1,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: _topUpTextField(),
      );
    }

    AmountTemplateItem _templateAmountItem(int amount) {
      return AmountTemplateItem(
        amount: amount,
        isSelected: amount == selectedAmount,
        onTap: () {
          setState(() {
            if (amount != selectedAmount) {
              selectedAmount = amount;
            } else {
              selectedAmount = 0;
            }

            _amountController.text = selectedAmount.toString();
          });
        },
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
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                controller: ScrollController(
                  keepScrollOffset: true,
                ),
                childAspectRatio: (90 / 80),
                children: [
                  _templateAmountItem(10000),
                  _templateAmountItem(25000),
                  _templateAmountItem(50000),
                  _templateAmountItem(100000),
                  _templateAmountItem(250000),
                  _templateAmountItem(500000),
                  _templateAmountItem(750000),
                  _templateAmountItem(1000000),
                  _templateAmountItem(10000000),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _button() {
      return (selectedAmount > 0)
          ? Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width - 80,
                onPressed: () {
                  final isValid = _key.currentState!.validate();

                  if (isValid) {
                    _key.currentState!.save();
                  }
                },
                text: 'Top Up Now',
                color: orangeColor2,
              ),
            )
          : SizedBox();
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
