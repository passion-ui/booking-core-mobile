import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class LocationItem extends StatelessWidget {
  final CategoryEntity? data;
  final Function(CategoryEntity)? onPressed;
  final ListingViewStyle style;

  const LocationItem({
    super.key,
    this.data,
    this.onPressed,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return InkWell(
      onTap: () => onPressed!(data!),
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).cardColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedImage(
              url: data!.image,
              borderRadius: BorderRadius.circular(12),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                data!.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
