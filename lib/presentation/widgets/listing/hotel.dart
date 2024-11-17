import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class Hotel extends StatelessWidget {
  final HotelEntity data;
  final ListingViewStyle style;
  final Function(HotelEntity)? onPressed;
  final String? currency;

  const Hotel({
    super.key,
    required this.data,
    required this.style,
    this.onPressed,
    this.currency,
  });

  /// Build the normal view of the hotel.
  Widget _buildNormal(BuildContext context) {
    return Box(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => onPressed!(data),
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedImage(url: data.image, height: 160),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Rating(value: data.review.score),
                    const SizedBox(height: 4),
                    Text(
                      data.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.location.name,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${data.review.score}/5',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data.review.text,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${data.review.total} ${Translate.of(context).translate('reviews')})',
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
                          '$currency${data.price.toStringAsFixed(0)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
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
