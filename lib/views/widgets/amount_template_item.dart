part of 'widgets.dart';

class AmountTemplateItem extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final Function onTap;

  AmountTemplateItem(
      {required this.amount, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: isSelected ? blackColor2.withOpacity(0.95) : whiteColor2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: secondaryColor,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'IDR',
                style: isSelected
                    ? whiteTextStyle2.copyWith(fontSize: 16)
                    : hintTextStyle.copyWith(
                        fontSize: 16,
                      ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'ID',
                  symbol: '',
                  decimalDigits: 0,
                ).format(amount),
                style: isSelected
                    ? whiteTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      )
                    : regularTextStyle.copyWith(
                        fontSize: 16,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
