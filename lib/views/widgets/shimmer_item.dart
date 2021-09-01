part of 'widgets.dart';

class ShimmerItem extends StatelessWidget {
  final double width;
  final double height;

  ShimmerItem({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: blackColor1,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadiusDirectional.circular(16),
        ),
      ),
    );
  }
}
