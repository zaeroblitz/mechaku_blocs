part of 'widgets.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final int itemCount;
  final CategoryModel category;

  CategoryItem(
      {required this.index, required this.itemCount, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      height: 80,
      margin: EdgeInsets.only(
        left: (index == 0) ? 20 : 0,
        right: (index != itemCount) ? 20 : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(category.banner),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 288,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  blackColor2.withOpacity(0.9),
                  blackColor2.withOpacity(0.25),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  // Category Name
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextStyle1.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),

                  // Next Icon
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 8,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: blackColor2,
                      size: 20,
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
