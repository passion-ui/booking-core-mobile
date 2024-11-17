import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ServicesBlock extends StatelessWidget {
  final Function(BookingEntity)? onPressed;
  final List<BookingEntity>? items;

  const ServicesBlock({
    super.key,
    this.items,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    if (items != null && items!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          shrinkWrap: true,
          childAspectRatio: 1.2,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          children: items!.map((item) {
            return GestureDetector(
              onTap: () => onPressed!(item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color.withOpacity(.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      IconFactory.get(item.icon),
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        shrinkWrap: true,
        childAspectRatio: 1.2,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(8, (index) {
          return Skeleton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
