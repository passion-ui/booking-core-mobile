import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class TourCart extends StatefulWidget {
  final ProductDetailCubit cubit;

  const TourCart({super.key, required this.cubit});

  @override
  State<TourCart> createState() => _TourCartState();
}

class _TourCartState extends State<TourCart> {
  String currency = '';

  @override
  void initState() {
    super.initState();

    final config = context.read<ConfigsBloc>().state;
    if (config is ConfigsSuccess) {
      currency = config.data.currency.symbol;
    }
  }

  /// On booking
  void _onBooking() {
    context.push(Routers.checkout, extra: widget.cubit);
  }

  /// Show date picker
  void _showDatePicker() async {
    final cubit = widget.cubit;
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: cubit.startDate,
      currentDate: cubit.startDate,
    );

    if (picked != null) {
      cubit.startDate = picked;
      cubit.updateCart();
    }
  }

  Widget _buildFooter(ProductDetailState state) {
    if (state is TourDetailSuccess) {
      List<Widget> fees = [];
      if (state.product.bookingFees?.isNotEmpty == true) {
        fees = state.product.bookingFees!.map((service) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translate.of(context).translate(service.name),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                '$currency${service.price}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          );
        }).toList();
      }
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(20),
              offset: Offset(0, -2),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    ...fees,
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Translate.of(context).translate(
                                  'total_price',
                                ),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '$currency${widget.cubit.product.price.toStringAsFixed(0)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  const SizedBox(width: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      '/${Translate.of(context).translate('room')}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: _onBooking,
                          child: Text(
                            Translate.of(context).translate('book_now'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: widget.cubit,
      builder: (context, state) {
        Widget content = Container();
        if (state is TourDetailSuccess) {
          final startDate = DateFormat('yyyy/MM/dd').format(
            widget.cubit.startDate,
          );
          content = SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Box(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: _showDatePicker,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Translate.of(context).translate(
                                      'please_select_date',
                                    ),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    startDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context).translate('adult'),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Steps(
                              value: widget.cubit.adults,
                              onChanged: (value) {
                                widget.cubit.adults = value;
                                widget.cubit.updateCart();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context).translate('child'),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Steps(
                              value: widget.cubit.children,
                              onChanged: (value) {
                                widget.cubit.children = value;
                                widget.cubit.updateCart();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Box(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Translate.of(context).translate('cleaning'),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '(${currency}100)',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: widget.cubit.useClean,
                                onChanged: (value) {
                                  setState(() {
                                    widget.cubit.useClean = value!;
                                  });
                                },
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

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('booking'),
            ),
          ),
          body: content,
          bottomNavigationBar: _buildFooter(state),
        );
      },
    );
  }
}
