import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class CarCart extends StatefulWidget {
  final ProductDetailCubit cubit;

  const CarCart({super.key, required this.cubit});

  @override
  State<CarCart> createState() => _CarCartState();
}

class _CarCartState extends State<CarCart> {
  final _pickupController = TextEditingController();
  final _dropOffController = TextEditingController();
  final _pickupFocusNode = FocusNode();
  final _dropOffFocusNode = FocusNode();

  String currency = '';

  @override
  void initState() {
    super.initState();

    final config = context.read<ConfigsBloc>().state;
    if (config is ConfigsSuccess) {
      currency = config.data.currency.symbol;
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropOffController.dispose();
    _pickupFocusNode.dispose();
    _dropOffFocusNode.dispose();
    super.dispose();
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

    if (picked != null) {
      cubit.startDate = picked.start;
      cubit.endDate = picked.end;
      cubit.updateCart();
    }
  }

  Widget _buildFooter(ProductDetailState state) {
    if (state is CarDetailSuccess) {
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
        if (state is CarDetailSuccess) {
          final startDate = DateFormat('yyyy/MM/dd').format(
            widget.cubit.startDate,
          );
          final endDate = DateFormat('yyyy/MM/dd').format(
            widget.cubit.endDate,
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
                                      'check_in_check_out',
                                    ),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '$startDate ~ $endDate',
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
                              Translate.of(context).translate('number'),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Steps(
                              value: widget.cubit.number,
                              onChanged: (value) {
                                widget.cubit.number = value;
                                widget.cubit.updateCart();
                              },
                            ),
                          ],
                        ),
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
                                'toddler_child_seat',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: widget.cubit.useToddlerSeat,
                                onChanged: (value) {
                                  widget.cubit.useToddlerSeat = value!;
                                  widget.cubit.updateCart();
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
                                'infant_child_seat',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: widget.cubit.useInfantSeat,
                                onChanged: (value) {
                                  widget.cubit.useInfantSeat = value!;
                                  widget.cubit.updateCart();
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
                                'gps_satellite',
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: widget.cubit.useGpsSatellite,
                                onChanged: (value) {
                                  widget.cubit.useGpsSatellite = value!;
                                  widget.cubit.updateCart();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Box(
                    child: Column(
                      children: [
                        TextField(
                          controller: _pickupController,
                          focusNode: _pickupFocusNode,
                          decoration: InputDecoration(
                            labelText: Translate.of(context).translate(
                              'pickup_location',
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _pickupController.clear();
                              },
                            ),
                          ),
                          onSubmitted: (value) {
                            _dropOffFocusNode.requestFocus();
                          },
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _dropOffController,
                          focusNode: _dropOffFocusNode,
                          decoration: InputDecoration(
                            labelText: Translate.of(context).translate(
                              'drop_off_location',
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _dropOffController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
