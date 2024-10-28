import 'package:booking/presentation/presentation.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  ///On Setting
  void _onSetting(BuildContext context) {
    context.push(Routers.settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('account'),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Box(
                    child: Column(
                      children: [
                        ListTitle(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.cyan.withAlpha(80),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.settings_outlined,
                              color: Colors.cyan,
                            ),
                          ),
                          title: Translate.of(context).translate('settings'),
                          onPress: () => _onSetting(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
