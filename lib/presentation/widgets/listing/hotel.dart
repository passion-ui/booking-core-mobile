import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class HotelItem extends StatelessWidget {
  final HotelEntity? data;
  final ListingViewStyle style;
  final Function(HotelEntity)? onPressed;
  final Function(HotelEntity)? onAction;

  final String? currency;

  const HotelItem({
    super.key,
    this.data,
    required this.style,
    this.onPressed,
    this.onAction,
    this.currency,
  });

  /// Build the card view of the hotel.
  Widget _buildCard(BuildContext context) {
    if (data == null) {
      return Skeleton(
        child: Container(
          width: 240,
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Theme.of(context).cardColor,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget featured = const SizedBox.shrink();
    Widget sale = Row(
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );

    if (data!.isFeatured) {
      featured = Positioned(
        left: 8,
        top: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            Translate.of(context).translate('featured'),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    }

    if (data!.saleOff.isNotEmpty) {
      sale = Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '-${data!.saleOff}',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${currency ?? ''}${data!.price.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              Translate.of(context).translate('from'),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$currency${data!.salePrice.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      );
    }

    return GestureDetector(
      onTap: () => onPressed!(data!),
      child: Container(
        width: 240,
        height: 260,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).cardColor,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedImage(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    url: data!.image,
                  ),
                  featured,
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
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
                        color: Colors.black.withAlpha(150),
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
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Colors.amber,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                      const SizedBox(width: 4),
                      Text(
                        '(${data!.review.total} ${Translate.of(context).translate('reviews')})',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  sale,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the list view of the hotel.
  Widget _buildList(BuildContext context) {
    if (data == null) {
      return Skeleton(
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 12),
                    Container(
                      height: 14,
                      width: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 250,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget featured = const SizedBox.shrink();
    Widget sale = Row(
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );

    if (data!.isFeatured) {
      featured = Positioned(
        left: 8,
        top: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            Translate.of(context).translate('featured'),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    }

    if (data!.saleOff.isNotEmpty) {
      sale = Wrap(
        alignment: WrapAlignment.start,
        spacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '-${data!.saleOff}',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${currency ?? ''}${data!.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Theme.of(context).colorScheme.error,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
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
                '$currency${data!.salePrice.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
          )
        ],
      );
    }

    return GestureDetector(
      onTap: () => onPressed!(data!),
      child: Row(
        children: [
          Stack(
            children: [
              CachedImage(
                url: data!.image,
                width: 120,
                height: 120,
                borderRadius: BorderRadius.circular(12),
              ),
              featured
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(height: 8),
                  sale,
                  const SizedBox(height: 4),
                  Rating(value: data!.review.score),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        data!.review.text,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '(${data!.review.total} ${Translate.of(context).translate('reviews')})',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (onAction != null) {
                onAction!(data!);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case ListingViewStyle.card:
        return _buildCard(context);

      case ListingViewStyle.list:
        return _buildList(context);

      default:
        return _buildCard(context);
    }
  }
}
