import 'package:booking/presentation/presentation.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onDestinationSelected(int index) async {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        onDestinationSelected: _onDestinationSelected,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: Translate.of(context).translate('home'),
          ),
          NavigationDestination(
            selectedIcon: Badge(child: Icon(Icons.favorite)),
            icon: BlocBuilder<WishListCubit, WishListState>(
              builder: (context, wishlist) {
                if (wishlist is WishListSuccess && wishlist.data.total > 0) {
                  return Badge(
                    label: Text('${wishlist.data.total}'),
                    child: Icon(Icons.favorite),
                  );
                }
                return Badge(
                  child: Icon(Icons.favorite_border),
                );
              },
            ),
            label: Translate.of(context).translate('wishlist'),
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: Translate.of(context).translate('news'),
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle_rounded),
            icon: Icon(Icons.account_circle_outlined),
            label: Translate.of(context).translate('account'),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          Home(),
          WishList(),
          News(),
          Account(),
        ],
      ),
    );
  }
}
