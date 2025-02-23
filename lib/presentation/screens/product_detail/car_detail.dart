import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class CarDetail extends StatefulWidget {
  final CarEntity item;

  const CarDetail({super.key, required this.item});

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> with ProductDetailBase {
  @override
  void initState() {
    productDetailCubit = CarDetailCubit();
    item = widget.item;
    super.initState();
  }

  @override
  Widget buildContent(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      final product = state.product as CarEntity;
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
                          Icons.person_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('passenger'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      '${product.passenger} ${Translate.of(context).translate('slot')}',
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
                          Icons.luggage_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('baggage'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      '${product.baggage} ${Translate.of(context).translate('bag')}',
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
                          Icons.window_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('window'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      '${product.door} ${Translate.of(context).translate('door')}',
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
                          Icons.settings_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Translate.of(context).translate('gear'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    Text(
                      product.gear,
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
      final product = state.product as CarEntity;
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
                  '/${Translate.of(context).translate('day')}',
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
                    '/${Translate.of(context).translate('day')}',
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
