import 'package:booking/presentation/presentation.dart';

import 'picker_item.dart';

class BottomSheetSelect extends StatefulWidget {
  final String? title;
  final List items;
  final bool multiples;
  final List selected;

  const BottomSheetSelect({
    super.key,
    this.title,
    required this.items,
    required this.multiples,
    required this.selected,
  });

  @override
  createState() => _BottomSheetSelectState();
}

class _BottomSheetSelectState<T> extends State<BottomSheetSelect> {
  List _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    String title = Translate.of(context).translate('select_options');
    if (widget.title != null) {
      title = widget.title!;
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
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = widget.items[index];
                  final selected = _selectedItems.contains(item);

                  if (selected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }

                  return PickerItem(
                    title: item.title,
                    leading: item.leading,
                    trailing: trailing,
                    onPress: () {
                      if (widget.multiples) {
                        if (selected) {
                          _selectedItems.remove(item);
                        } else {
                          _selectedItems.add(item);
                        }
                      } else {
                        _selectedItems = [item];
                      }
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      context.pop(_selectedItems);
                    },
                    child: Text(Translate.of(context).translate('apply')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
