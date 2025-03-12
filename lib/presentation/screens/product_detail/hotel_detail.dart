import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> with ProductDetailBase {
  @override
  PreferredSizeWidget buildHeader(ProductDetailState state) {
    Widget content = Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(20),
            offset: Offset(0, 2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Skeleton(
                child: Container(
                  height: 12,
                  width: 100,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Skeleton(
                child: Container(
                  height: 16,
                  width: 250,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(width: 12),
          Skeleton(
            child: Container(
              height: 32,
              width: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (state is HotelDetailSuccess) {
      final product = state.product as HotelEntity;
      Widget feature = Container();
      if (product.isFeatured) {
        feature = Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Translate.of(context).translate('featured'),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(width: 8),
          ],
        );
      }

      content = Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(20),
              offset: Offset(0, 2),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Rating(
                    value: product.point ?? 0.0,
                    size: 16,
                  ),
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Row(children: [
              feature,
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: onFavorite,
                  icon: Icon(Icons.favorite_outline),
                ),
              ),
            ]),
          ],
        ),
      );
    }

    return PreferredSize(
      preferredSize: Size(0, 80),
      child: content,
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('check_in_time'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      product.checkInTime ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
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
                          Icons.access_time,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('check_out_time'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      product.checkOutTime ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                policies,
              ],
            ),
          ),
        ],
      );
    }

    return Container();
  }

  @override
  Widget? buildFooterActions(ProductDetailState state) {
    if (state is HotelDetailSuccess) {
      String currency = '';
      final config = context.read<ConfigsBloc>().state;
      if (config is ConfigsSuccess) {
        currency = config.data.currency.symbol;
      }
      final product = state.product as HotelEntity;
      Widget info = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate('from'),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Row(
            children: [
              Text(
                '$currency${product.price.toStringAsFixed(0)}',
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

      if (product.saleOff.isNotEmpty) {
        info = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    '-${product.saleOff}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '$currency${product.price.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
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
                  '$currency${product.salePrice.toStringAsFixed(0)}',
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

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(child: info),
              FilledButton(
                onPressed: onCart,
                child: Text(
                  Translate.of(context).translate('book_now'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return null;
  }
}
