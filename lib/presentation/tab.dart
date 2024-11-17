import 'package:booking/presentation/presentation.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int currentPageIndex = 0;

  void _onDestinationSelected(int index) async {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeBloc()..add(OnLoad()),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
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
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.favorite_border),
              ),
              label: Translate.of(context).translate('saved'),
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
            Saved(),
            News(),
            Account(),
          ],
        ),
      ),
    );
  }
}
