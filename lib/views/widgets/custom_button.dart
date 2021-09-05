part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final Color color;
  final Function() onPressed;
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.color = blackColor2,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: whiteTextStyle1.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
