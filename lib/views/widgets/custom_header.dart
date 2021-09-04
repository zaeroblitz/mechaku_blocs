part of 'widgets.dart';

class CustomHeader extends StatelessWidget {
  final ImageProvider headerBanner;
  final String headerTitle;

  CustomHeader({required this.headerBanner, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 90,
      margin: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: headerBanner,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  blackColor1.withOpacity(0.95),
                  blackColor1.withOpacity(0.25),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.read<PageCubit>().setPage(0),
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: whiteColor2,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        size: 24,
                        color: blackColor2,
                      ),
                    ),
                  ),
                  Text(
                    headerTitle,
                    style: whiteTextStyle1.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
