import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:share_plus/share_plus.dart';

import 'header.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _newsBloc = NewsBloc();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newsBloc.add(OnLoadNews());
  }

  ///On Refresh
  Future<void> _onRefresh() async {
    _newsBloc.add(OnLoadNews());
  }

  ///On New
  void _onNew(PostEntity item) {
    context.push(Routers.detailNew);
  }

  ///On share
  void _onShare(PostEntity item) {
    Share.share(
      'Check out  item ${item.url}',
      subject: item.title,
    );
  }

  ///On Author
  void _onAuthor(UserEntity item) {
    context.push(Routers.author);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: _newsBloc,
      builder: (context, news) {
        Widget list = SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              return PostItem(
                style: ListingViewStyle.list,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 12);
            },
            itemCount: 15,
          ),
        );

        if (news is NewsSuccess) {
          list = SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final item = news.data.items[index];
                return PostItem(
                  data: item,
                  onPressed: _onNew,
                  onAuthor: _onAuthor,
                  onShare: _onShare,
                  style: ListingViewStyle.list,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemCount: news.data.items.length,
            ),
          );
        }
        return Scaffold(
          body: RefreshIndicator(
            edgeOffset: 60 + MediaQuery.of(context).padding.top,
            onRefresh: _onRefresh,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: Header(
                    controller: _controller,
                    onChanged: (value) {
                      _newsBloc.add(OnLoadNews(keyword: value));
                    },
                    height: 60 + MediaQuery.of(context).padding.top,
                    onSort: () {},
                    onCategory: () {},
                  ),
                  floating: true,
                  pinned: true,
                ),
                list,
              ],
            ),
          ),
        );
      },
    );
  }
}
