import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class HotelItem extends StatelessWidget {
  final HotelEntity? data;
  final ListingViewStyle style;
  final Function(HotelEntity)? onPressed;
  final String? currency;

  const HotelItem({
    super.key,
    this.data,
    required this.style,
    this.onPressed,
    this.currency,
  });

  /// Build the normal view of the hotel.
  Widget _buildNormal(BuildContext context) {
    if (data == null) {
      return Skeleton(
        child: Container(
          width: 240,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 200,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 220,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => onPressed!(data!),
      child: Container(
        width: 240,
        height: 260,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedImage(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  url: data!.image,
                  height: 140,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          data!.review.score.toString(),
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.amber,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data!.location.name,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        data!.review.text,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${data!.review.total} ${Translate.of(context).translate('reviews')})',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          Translate.of(context).translate('from'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$currency${data!.price.toStringAsFixed(0)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          '/${Translate.of(context).translate('night')}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ListingViewStyle.normal:
        return _buildNormal(context);
      default:
        return _buildNormal(context);
    }
  }
}
