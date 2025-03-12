import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class BoatDetail extends StatefulWidget {
  const BoatDetail({super.key});

  @override
  State<BoatDetail> createState() => _BoatDetailState();
}

class _BoatDetailState extends State<BoatDetail> with ProductDetailBase {
  @override
  Widget buildContent(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      final product = state.product as BoatEntity;
      return Column(
        children: [
          SizedBox(height: 12),
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
                          Icons.group_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('guest'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      '${product.guests} ${Translate.of(context).translate('people')}',
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
                          Icons.cabin_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('cabin'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      '${product.cabins}',
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
                          Icons.height_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('length'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      product.length,
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
                          Icons.speed_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('speed'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      product.speed,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
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
    if (state is ProductDetailSuccess) {
      String currency = '';
      final config = context.read<ConfigsBloc>().state;
      if (config is ConfigsSuccess) {
        currency = config.data.currency.symbol;
      }
      final product = state.product as BoatEntity;
      Widget info = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate('from'),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            '$currency${product.price.toStringAsFixed(0)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
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
