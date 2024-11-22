import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:card_swiper/card_swiper.dart';

class OfferBlock extends StatelessWidget {
  final BlockOfferEntity? data;
  final Function(OfferEntity)? onPressed;

  const OfferBlock({
    super.key,
    this.data,
    this.onPressed,
  });

  Widget _buildFeatured(BuildContext context, OfferEntity item) {
    if (item.featured.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          item.featured,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildIcon(BuildContext context, OfferEntity item) {
    if (item.icon.isNotEmpty) {
      return Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          IconFactory.get(item.icon),
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeleton(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            )
          ],
        ),
      );
    }
    Widget title = SizedBox.shrink();
    Widget description = SizedBox.shrink();
    Widget header = SizedBox.shrink();
    Widget slider = SizedBox.shrink();

    if (data!.title.isNotEmpty) {
      title = Text(
        data!.title,
        style: Theme.of(context).textTheme.titleMedium,
      );
    }
    if (data!.description.isNotEmpty) {
      description = Text(
        data!.description,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    if (data!.title.isNotEmpty || data!.description.isNotEmpty) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          description,
          const SizedBox(height: 8),
        ],
      );
    }

    if (data!.items.isNotEmpty) {
      slider = Container(
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Swiper(
          itemBuilder: (context, index) {
            final item = data!.items[index];
            return Stack(
              children: [
                CachedImage(url: item.image),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description.replaceAll('<br>', ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildFeatured(context, item),
                    _buildIcon(context, item),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: SizedBox(
                    height: 32,
                    child: FilledButton.tonal(
                      onPressed: () {
                        onPressed!(item);
                      },
                      child: Text(
                        item.action,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: true,
          itemCount: data!.items.length,
          pagination: SwiperPagination(
            alignment: const Alignment(0.0, 1.1),
            builder: DotSwiperPaginationBuilder(
              activeColor: Theme.of(context).colorScheme.primary,
              color: Colors.white,
              size: 6,
              activeSize: 8,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          slider,
        ],
      ),
    );
  }
}
