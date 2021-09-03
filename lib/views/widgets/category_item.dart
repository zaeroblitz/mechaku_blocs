part of 'widgets.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final int itemCount;
  final CategoryModel category;

  CategoryItem({
    required this.index,
    required this.itemCount,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductByCategory) {
          Navigator.pushNamed(
            context,
            AppRoutes.category_page,
            arguments:
                CategoryArgument(category: category, products: state.products),
          );
        } else if (state is ProductFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: pinkColor,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<ProductCubit>().getProductsByCategory(category.name);
          },
          child: Container(
            width: 288,
            height: 80,
            margin: EdgeInsets.only(
              left: (index == 0) ? 20 : 16,
              right: (index == itemCount - 1) ? 20 : 0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: category.banner,
                  placeholder: (_, __) => ShimmerItem(width: 288, height: 80),
                  errorWidget: (context, url, error) => Container(),
                  imageBuilder: (context, imageProvider) {
                    return Stack(
                      children: [
                        // Category Banner
                        Container(
                          width: 288,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),

                        // Category Gradient
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
                      ],
                    );
                  },
                ),
                Center(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
