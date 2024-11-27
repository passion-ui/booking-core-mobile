import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Header extends SliverPersistentHeaderDelegate {
  final _focusNode = FocusNode();
  final double height;
  final VoidCallback onSort;
  final VoidCallback onCategory;
  final ValueChanged<String>? onChanged;

  final _controller = TextEditingController();

  Header({
    required this.onSort,
    required this.onCategory,
    required this.height,
    required this.onChanged,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: SearchBar(
                hintText: Translate.of(context).translate('search_news'),
                controller: _controller,
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
                },
                onChanged: onChanged,
                onSubmitted: (value) {
                  Logger.log("onSubmitted", value);
                },
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(width: 8),
            InkWell(
              onTap: onCategory,
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.filter_alt_outlined),
              ),
            ),
            SizedBox(width: 4),
            InkWell(
              onTap: onSort,
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.sort_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant Header oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}
