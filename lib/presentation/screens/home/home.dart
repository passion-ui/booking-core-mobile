import 'package:booking/presentation/presentation.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('home'),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  FilledButton(
                    onPressed: () {
                      context.push(Routers.saved);
                    },
                    child: Text("Button"),
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
