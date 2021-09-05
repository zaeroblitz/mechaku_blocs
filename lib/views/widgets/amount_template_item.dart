part of 'widgets.dart';

class AmountTemplateItem extends StatefulWidget {
  final int balance;

  AmountTemplateItem(this.balance);

  @override
  _AmountTemplateItemState createState() => _AmountTemplateItemState();
}

class _AmountTemplateItemState extends State<AmountTemplateItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TopUpCubit>().setSelectedTopUp(widget.balance);
        context.read<TopUpCubit>().isSelectedTopUp(widget.balance);
        setState(() {
          isSelected = context.read<TopUpCubit>().isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          color: isSelected ? blackColor2.withOpacity(0.75) : whiteColor2,
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
                ).format(widget.balance),
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
