part of 'widgets.dart';

class ProductNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_data.png',
            width: MediaQuery.of(context).size.width - 40,
          ),
          Text(
            'Ooops, products not found',
            style: regularTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () => context.read<PageCubit>().setPage(0),
            text: 'Get Back',
            width: MediaQuery.of(context).size.width - 120,
          ),
        ],
      ),
    );
  }
}
