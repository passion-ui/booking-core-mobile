import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class HotelCart extends StatefulWidget {
  final ProductDetailCubit cubit;

  const HotelCart({super.key, required this.cubit});

  @override
  State<HotelCart> createState() => _HotelCartState();
}

class _HotelCartState extends State<HotelCart> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  String currency = '';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    final config = context.read<ConfigsBloc>().state;
    if (config is ConfigsSuccess) {
      currency = config.data.currency.symbol;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Show gallery
  void _onGallery(RoomEntity item) {
    context.push(Routers.gallery, extra: item);
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
      cubit.checkAvailability();
    }
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

    if (context.mounted && (adult != cubit.adults || child != cubit.children)) {
      cubit.adults = adult;
      cubit.children = child;
      cubit.checkAvailability();
    }
  }

  /// On select room
  void _onSelect(RoomEntity item) async {
    final cubit = widget.cubit;
    final data = await showModalBottomSheet<List?>(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      builder: (BuildContext context) {
        List<PickerEntity> selected = [];
        final items = List.generate(item.quantity, (index) {
          final textRoom = Translate.of(context).translate('room');
          return PickerEntity(
            id: index.toString(),
            title: '$index $textRoom - $currency${item.price * index}',
          );
        });

        if (item.selected > 0) {
          selected = [
            PickerEntity(
              id: item.selected.toString(),
              title: '',
            ),
          ];
        }
        return BottomSheetSelect(
          items: items,
          multiples: false,
          selected: selected,
        );
      },
    );

    if (data != null && context.mounted) {
      item.selected = int.tryParse(data.first.id) ?? 0;
      cubit.updateCart();
    }
  }

  /// Build content
  Widget _buildContent(ProductDetailState state) {
    if (state is HotelDetailSuccess) {
      final startDate = DateFormat('yyyy/MM/dd').format(state.startDate);
      final endDate = DateFormat('yyyy/MM/dd').format(state.endDate);

      return Column(
        children: [
          Padding(
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
                                  'check_in_check_out',
                                ),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              SizedBox(height: 2),
                              Text(
                                '$startDate - $endDate',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                              'service_vip',
                            ),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: widget.cubit.useVIP,
                              onChanged: (value) {
                                setState(() {
                                  widget.cubit.useVIP = value!;
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
                              value: widget.cubit.useBreakfast,
                              onChanged: (value) {
                                setState(() {
                                  widget.cubit.useBreakfast = value!;
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: 0,
                left: 12,
                right: 12,
                bottom: 12,
              ),
              itemCount: state.rooms?.length ?? 8,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = state.rooms?[index];
                final selected = item != null && item.selected > 0;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: selected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RoomItem(
                    item: item,
                    onPressed: _onSelect,
                    onGallery: _onGallery,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: 8,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        return RoomItem(item: null);
      },
    );
  }

  /// Build footer
  Widget _buildFooter(ProductDetailState state) {
    if (state is HotelDetailSuccess) {
      final roomsSelected = state.rooms?.map((e) {
        return e.selected;
      }).reduce((a, b) {
        return a + b;
      });

      if (roomsSelected != null && roomsSelected > 0) {
        final totalPrice = state.rooms?.map((e) {
          return e.price * e.selected;
        }).reduce((a, b) {
          return a + b;
        });
        _animationController.forward();
        return SlideTransition(
          position: _offsetAnimation,
          child: Container(
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
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '$currency${totalPrice?.toStringAsFixed(0)}',
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
                                          '/$roomsSelected${Translate.of(context).translate('room')}',
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
          ),
        );
      } else {
        _animationController.reverse();
      }
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('booking'),
            ),
          ),
          body: _buildContent(state),
          bottomNavigationBar: _buildFooter(state),
        );
      },
    );
  }
}
