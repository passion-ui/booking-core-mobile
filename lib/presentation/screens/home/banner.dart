import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class BannerBlock extends StatelessWidget {
  final BlockBannerEntity? data;
  final Function(BannerEntity)? onPressed;

  const BannerBlock({
    super.key,
    this.data,
    this.onPressed,
  });

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
                  color: Theme.of(context).cardColor,
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
    Widget image = SizedBox.shrink();
    if (data!.item.image.isNotEmpty) {
      image = CachedImage(url: data!.item.image);
    }
    Widget banner = Container(
      height: 120,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Stack(
        children: [
          image,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data!.item.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    data!.item.description.replaceAll('<br>', ''),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: SizedBox(
              height: 32,
              child: FilledButton.tonal(
                onPressed: () {
                  onPressed!(data!.item);
                },
                child: Text(
                  data!.item.action,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );

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

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          banner,
        ],
      ),
    );
  }
}
