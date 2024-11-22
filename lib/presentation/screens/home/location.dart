import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class LocationBlock extends StatelessWidget {
  final BlockLocationEntity? data;
  final Function(CategoryEntity)? onPressed;

  const LocationBlock({
    super.key,
    this.data,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 4),
                  Container(
                    height: 12,
                    width: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 150,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 310,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ListingItem(style: ListingViewStyle.normal);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 8);
              },
              itemCount: 8,
            ),
          )
        ],
      );
    }

    Widget title = SizedBox.shrink();
    Widget description = SizedBox.shrink();
    Widget header = SizedBox.shrink();
    Widget listing = SizedBox.shrink();

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
      header = Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            description,
          ],
        ),
      );
    }

    if (data!.items.isNotEmpty) {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = data!.items[index];
            return LocationItem(
              data: item,
              onPressed: onPressed,
              style: ListingViewStyle.normal,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 8);
          },
          itemCount: data!.items.length,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        listing,
      ],
    );
  }
}
