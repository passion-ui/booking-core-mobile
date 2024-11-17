import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Header extends SliverPersistentHeaderDelegate {
  final _focusNode = FocusNode();
  final _controller = SearchController();
  final String? banner;
  final String? placeholder;
  final VoidCallback? onScan;

  Header({
    this.banner,
    this.placeholder,
    this.onScan,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    Widget image = Skeleton(
      child: Container(
        color: Colors.white,
      ),
    );
    if (banner != null) {
      image = CachedImage(
        url: banner!,
      );
    }
    String search = Translate.of(context).translate(
      'where_would_you_go',
    );
    if (placeholder != null && placeholder!.isNotEmpty) {
      search = placeholder!;
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Expanded(
                child: Opacity(
                  opacity: (1 - shrinkOffset / minExtent).clamp(0.0, 1.0),
                  child: image,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SearchAnchor(
            searchController: _controller,
            viewOnSubmitted: (value) {
              Logger.log("viewOnSubmitted", value);
            },
            viewOnChanged: (value) {
              Logger.log("viewOnChanged", value);
            },
            builder: (context, controller) {
              return SearchBar(
                hintText: search,
                focusNode: _focusNode,
                shadowColor: WidgetStateProperty.resolveWith((states) {
                  return Theme.of(context).colorScheme.surfaceContainerLowest;
                }),
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  return Theme.of(context).colorScheme.surfaceContainerLowest;
                }),
                onTapOutside: (value) {
                  Logger.log("onTapOutside", value);
                  _focusNode.unfocus();
                },
                onTap: () {
                  Logger.log("onTap");
                  _focusNode.unfocus();
                  controller.openView();
                },
                onChanged: (value) {
                  Logger.log("onChanged", value);
                  _focusNode.unfocus();
                  controller.openView();
                },
                onSubmitted: (value) {
                  Logger.log("onSubmitted", value);
                  _focusNode.unfocus();
                },
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.search),
                ),
                trailing: <Widget>[
                  SizedBox(
                    height: 32,
                    child: VerticalDivider(),
                  ),
                  IconButton(
                    onPressed: onScan,
                    icon: Icon(Icons.qr_code_scanner),
                  )
                ],
              );
            },
            suggestionsBuilder: (context, controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {},
                );
              });
            },
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 246;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(covariant Header oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent ||
        banner != oldDelegate.banner;
  }
}
