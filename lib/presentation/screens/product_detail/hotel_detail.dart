import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class HotelDetail extends StatefulWidget {
  final HotelEntity item;

  const HotelDetail({super.key, required this.item});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> with ProductDetailBase {
  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  @override
  Widget buildTitle(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      final product = item as HotelEntity;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Rating(
            value: product.point ?? 0.0,
            size: 16,
          ),
          const SizedBox(height: 2),
          Text(
            product.title,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Skeleton(
          child: Container(height: 12, width: 100, color: Colors.white),
        ),
        SizedBox(height: 8),
        Skeleton(
          child: Container(height: 16, width: 250, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget buildContent(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      final product = state.product as HotelEntity;
      Widget policies = SizedBox.shrink();
      if (product.policies?.isNotEmpty == true) {
        policies = Column(
          children: [
            const SizedBox(height: 8),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = product.policies![index];
                return ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal: 12),
                  childrenPadding: EdgeInsets.zero,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none,
                  ),
                  title: Text(
                    item.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        item.content,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8);
              },
              itemCount: product.policies?.length ?? 0,
            ),
          ],
        );
      }

      return Column(
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translate.of(context).translate('hotel_policies'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                Translate.of(context)
                                    .translate('check_in_time'),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          Text(
                            product.checkInTime ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                Translate.of(context)
                                    .translate('check_out_time'),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          Text(
                            product.checkOutTime ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                policies,
              ],
            ),
          ),
        ],
      );
    }
    return Container();
  }
}
