import 'package:booking/presentation/presentation.dart';

class Header extends SliverPersistentHeaderDelegate {
  final _focusNode = FocusNode();
  final double height;
  final VoidCallback onSort;
  final VoidCallback onCategory;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  Header({
    required this.onSort,
    required this.onCategory,
    required this.height,
    required this.controller,
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
                controller: controller,
                focusNode: _focusNode,
                shadowColor: WidgetStateProperty.resolveWith((states) {
                  return Theme.of(context).colorScheme.surfaceContainerLowest;
                }),
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  return Theme.of(context).colorScheme.surfaceContainerLowest;
                }),
                onTapOutside: (value) {
                  _focusNode.unfocus();
                },
                onTap: () {
                  _focusNode.requestFocus();
                },
                onSubmitted: (value) {
                  _focusNode.unfocus();
                },
                onChanged: onChanged,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(Icons.search),
                ),
                trailing: [
                  if (controller.text.isNotEmpty)
                    InkWell(
                      onTap: () {
                        controller.clear();
                        onChanged?.call('');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(Icons.clear),
                      ),
                    ),
                ],
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
