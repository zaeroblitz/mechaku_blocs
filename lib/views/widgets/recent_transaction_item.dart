part of 'widgets.dart';

class RecentTransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  RecentTransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: whiteColor2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 90,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: (transaction.picture == '')
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/card_top_up.png'),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(transaction.picture),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: mediumTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'ID',
                    symbol: 'IDR ',
                    decimalDigits: 2,
                  ).format(transaction.amount),
                  style: (transaction.title == 'Top Up')
                      ? greenTextStyle.copyWith(fontSize: 12)
                      : pinkTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  transaction.date,
                  style: hintTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
