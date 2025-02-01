import 'package:booking/presentation/presentation.dart';

class Header extends SliverPersistentHeaderDelegate {
  final _focusNode = FocusNode();
  final String? banner;
  final String? placeholder;
  final VoidCallback? onScan;
  final VoidCallback? onSearch;
  final double minHeight;
  final double maxHeight;

  Header({
    this.banner,
    this.placeholder,
    this.onScan,
    this.onSearch,
    required this.minHeight,
    required this.maxHeight,
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
    String search = Translate.of(context).translate('where_would_you_go');
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
              SizedBox(height: 36),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SearchBar(
            hintText: search,
            focusNode: _focusNode,
            shadowColor: WidgetStateProperty.resolveWith((states) {
              return Theme.of(context).cardColor;
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return Theme.of(context).cardColor;
            }),
            onTapOutside: (value) {
              _focusNode.unfocus();
            },
            onTap: () {
              _focusNode.unfocus();
              onSearch?.call();
            },
            leading: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.search),
              ),
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
            keyboardType: TextInputType.text,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant Header oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent ||
        banner != oldDelegate.banner;
  }
}
