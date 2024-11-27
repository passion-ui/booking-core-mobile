import 'package:booking/presentation/presentation.dart';

class BottomSheetAction<T> extends StatelessWidget {
  final String? title;
  final List<T> items;

  const BottomSheetAction({
    super.key,
    this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    String title = Translate.of(context).translate('select_options');
    if (this.title != null) {
      title = this.title!;
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withAlpha(100),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 44),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final dynamic item = items[index];
                  return ListTitle(
                    leading: item.leading,
                    title: item.title,
                    onPress: () {
                      context.pop(item);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
