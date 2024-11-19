import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class TourItem extends StatelessWidget {
  final TourEntity? data;
  final ListingViewStyle style;
  final Function(TourEntity)? onPressed;
  final String? currency;

  const TourItem({
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
        child: SizedBox(
          width: 280,
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
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 120,
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
        width: 280,
        height: 310,
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
                  url: data!.image,
                  height: 160,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                Positioned(
                  bottom: 8,
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    data!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Rating(value: data!.review.score),
                      const SizedBox(width: 8),
                      Text(
                        '(${data!.review.total} ${Translate.of(context).translate('reviews')})',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            data!.duration,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${currency ?? ''}${data!.salePrice.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      )
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
