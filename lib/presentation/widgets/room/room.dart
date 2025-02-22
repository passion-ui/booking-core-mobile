import 'package:booking/core/utils/icons.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class RoomItem extends StatelessWidget {
  final RoomEntity? item;
  final Function(RoomEntity)? onPressed;
  final Function(RoomEntity)? onGallery;

  const RoomItem({
    super.key,
    required this.item,
    this.onPressed,
    this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return InkWell(
        onTap: () => onPressed!(item!),
        child: Container(
          height: 340,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Theme.of(context).hoverColor,
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
                      url: item!.image,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () => onGallery!(item!),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.photo_library_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
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
                      item!.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.square_foot_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              Translate.of(context).translate('size'),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          '${item!.size} m²',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.bed_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              Translate.of(context).translate('bed'),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          item!.bed,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              Translate.of(context).translate('adult'),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          item!.adults,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.child_care_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              Translate.of(context).translate('child'),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Text(
                          item!.children,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Divider(),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 40,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: item!.features.length,
                      itemBuilder: (context, index) {
                        final child = item!.features[index];
                        return Row(
                          children: [
                            Icon(
                              IconFactory.get(
                                child.icon,
                                defaultIcon: Icons.check_circle_outline,
                              ),
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                Translate.of(context).translate(child.title),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Theme.of(context).hoverColor,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Skeleton(
              child: Container(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (index, context) {
                return Skeleton(
                  child: Container(
                    height: 12,
                    color: Colors.white,
                  ),
                );
              },
              separatorBuilder: (index, context) {
                return SizedBox(height: 8);
              },
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
