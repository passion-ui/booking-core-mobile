import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class PostItem extends StatelessWidget {
  final PostEntity? data;
  final ListingViewStyle style;
  final Function(PostEntity)? onPressed;
  final Function(UserEntity)? onAuthor;
  final Function(PostEntity)? onShare;

  const PostItem({
    super.key,
    this.data,
    required this.style,
    this.onPressed,
    this.onAuthor,
    this.onShare,
  });

  /// Build the card view of the post new.
  Widget _buildCard(BuildContext context) {
    if (data == null) {
      return Skeleton(
        child: Container(
          width: 280,
          height: 330,
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
              Container(height: 160, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 100,
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
                      width: 200,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 14,
                              width: 150,
                              color: Colors.white,
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

    return GestureDetector(
      onTap: () => onPressed!(data!),
      child: Container(
        width: 280,
        height: 330,
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
              child: CachedImage(url: data!.image),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.category.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data!.content,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Divider(),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => onAuthor!(data!.author),
                        child: Row(
                          children: [
                            CachedImage(
                              url: data!.author.avatar,
                              width: 36,
                              height: 36,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!.author.displayName,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  data!.createdAt,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => onShare!(data!),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            ),
                          ),
                          child: const Icon(
                            Icons.share_outlined,
                            size: 18,
                          ),
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

  /// Build the list view of the post new.
  Widget _buildList(BuildContext context) {
    if (data == null) {
      return Skeleton(
        child: Container(
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
              Container(height: 160, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 100,
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
                      width: 200,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Divider(),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              width: 100,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 14,
                              width: 150,
                              color: Colors.white,
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

    return GestureDetector(
      onTap: () => onPressed!(data!),
      child: Container(
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
            CachedImage(
              url: data!.image,
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.category.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data!.content,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Divider(),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => onAuthor!(data!.author),
                        child: Row(
                          children: [
                            CachedImage(
                              url: data!.author.avatar,
                              width: 36,
                              height: 36,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!.author.displayName,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  data!.createdAt,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => onShare!(data!),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            ),
                          ),
                          child: const Icon(
                            Icons.share_outlined,
                            size: 18,
                          ),
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
      case ListingViewStyle.card:
        return _buildCard(context);

      case ListingViewStyle.list:
        return _buildList(context);

      default:
        return _buildCard(context);
    }
  }
}
