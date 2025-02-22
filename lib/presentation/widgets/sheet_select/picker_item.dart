import 'package:flutter/material.dart';

class PickerItem extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? description;
  final VoidCallback onPress;

  const PickerItem({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    required this.onPress,
  });

  Widget _buildLeading(BuildContext context) {
    if (leading != null) {
      return Row(
        children: [
          leading!,
          SizedBox(width: 8.0),
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildTrailing(BuildContext context) {
    if (trailing != null) {
      return Row(
        children: [
          SizedBox(width: 8.0),
          trailing!,
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildDescription(BuildContext context) {
    if (description != null && description!.isNotEmpty) {
      return Text(
        description!,
        style: Theme.of(context).textTheme.labelSmall,
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        constraints: BoxConstraints(minHeight: 40.0),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Colors.transparent,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(15),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLeading(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  _buildDescription(context),
                ],
              ),
            ),
            _buildTrailing(context)
          ],
        ),
      ),
    );
  }
}
