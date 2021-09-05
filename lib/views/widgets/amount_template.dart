part of 'widgets.dart';

class AmounTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      controller: ScrollController(
        keepScrollOffset: true,
      ),
      childAspectRatio: (90 / 80),
      children: [
        AmountTemplateItem(10000),
        AmountTemplateItem(25000),
        AmountTemplateItem(50000),
        AmountTemplateItem(100000),
        AmountTemplateItem(150000),
        AmountTemplateItem(200000),
        AmountTemplateItem(250000),
        AmountTemplateItem(500000),
        AmountTemplateItem(1000000),
      ],
    );
  }
}
