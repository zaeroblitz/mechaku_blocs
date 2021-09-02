part of 'pages.dart';

class MainPage extends StatelessWidget {
  final List<SalomonBottomBarItem> _bottomNavItem = [
    SalomonBottomBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('Home'),
    ),
    SalomonBottomBarItem(
      icon: Icon(CupertinoIcons.chat_bubble),
      title: Text('Chat'),
    ),
    SalomonBottomBarItem(
      icon: Icon(CupertinoIcons.heart),
      title: Text('Wishlists'),
    ),
    SalomonBottomBarItem(
      icon: Icon(CupertinoIcons.creditcard),
      title: Text('Wallet'),
    ),
    SalomonBottomBarItem(
      icon: Icon(CupertinoIcons.person),
      title: Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget _body(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return Homepage();
        case 1:
          return ChatPage();
        case 2:
          return WishlistPage();
        case 3:
          return WalletPage();
        case 4:
          return SettingsPage();
        default:
          return Homepage();
      }
    }

    Widget _bottomNav(int currentIndex) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: SalomonBottomBar(
            items: _bottomNavItem,
            itemPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            margin: EdgeInsets.all(16),
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<PageCubit>().setPage(index);
            },
            selectedItemColor: blackColor1,
            selectedColorOpacity: 0.15,
            unselectedItemColor: greyColor,
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (_, currentIndex) {
        return Scaffold(
          body: Stack(
            children: [
              _body(currentIndex),
              _bottomNav(currentIndex),
            ],
          ),
          backgroundColor: bgColor,
        );
      },
    );
  }
}
