import 'package:booking/presentation/presentation.dart';

import 'header.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: Header(
              height: 60 + MediaQuery.of(context).padding.top,
              onSort: () {
                context.go(Routers.listing);
              },
              onCategory: () {
                context.go(Routers.listing);
              },
            ),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTitle(
                    title: 'News Title',
                    description: 'News Description',
                    onPress: () {
                      context.go(Routers.listing);
                    },
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
