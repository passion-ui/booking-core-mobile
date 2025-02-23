import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class CarCart extends StatefulWidget {
  final CarDetailCubit cubit;

  const CarCart({super.key, required this.cubit});

  @override
  State<CarCart> createState() => _CarCartState();
}

class _CarCartState extends State<CarCart> {
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
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: DateTimeRange(
        start: cubit.startDate,
        end: cubit.endDate,
      ),
    );

    if (picked != null) {}
  }

  /// Show select guests
  void _onSelectGuests() async {
    final cubit = widget.cubit;
    int adult = cubit.adults;
    int child = cubit.children;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context).translate('adult'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Steps(
                          value: adult,
                          onChanged: (value) {
                            setState(() {
                              adult = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context).translate('child'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Steps(
                          value: child,
                          onChanged: (value) {
                            setState(() {
                              child = value;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (adult != cubit.adults || child != cubit.children) {}
  }

  Widget _buildFooter(ProductDetailState state) {
    if (state is SpaceDetailSuccess) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translate.of(context).translate('service_fee'),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          '${currency}0',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
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
                                    '$currency${state.product.price.toStringAsFixed(0)}',
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
    return BlocBuilder<CarDetailCubit, ProductDetailState>(
      bloc: widget.cubit,
      builder: (context, state) {
        Widget content = Container();
        if (state is SpaceDetailSuccess) {
          final startDate = DateFormat('yyyy/MM/dd').format(state.startDate);
          content = SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Box(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: _showDatePicker,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Translate.of(context).translate(
                                    'please_select_date',
                                  ),
                                  style: Theme.of(context).textTheme.labelSmall,
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
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          width: 24,
                          child: VerticalDivider(),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: _onSelectGuests,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Translate.of(context).translate('guests'),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${state.adults} ${Translate.of(context).translate('adult')}, ${state.children} ${Translate.of(context).translate('child')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
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
                            Text(
                              Translate.of(context).translate(
                                'garden',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: state.garden,
                                onChanged: (value) {
                                  setState(() {
                                    state.garden = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context).translate(
                                'cleaning',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: state.clean,
                                onChanged: (value) {
                                  setState(() {
                                    state.clean = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translate.of(context).translate(
                                'breakfast',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: state.breakfast,
                                onChanged: (value) {
                                  setState(() {
                                    state.breakfast = value!;
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
              Translate.of(context).translate('configuration'),
            ),
          ),
          body: content,
          bottomNavigationBar: _buildFooter(state),
        );
      },
    );
  }
}
