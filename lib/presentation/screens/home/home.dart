import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'header.dart';
import 'offers.dart';
import 'services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  ///On Scan
  void _onScan() {
    context.go(Routers.listing);
  }

  ///On Booking
  void _onBooking(BookingEntity item) {
    context.go(Routers.listing);
  }

  ///On Booking
  void _onOffer(OfferEntity item) {
    context.go(Routers.listing);
  }

  ///Build block
  List<Widget> _buildBlock(BlockHomeEntity block) {
    if (block is BlockServicesEntity) {
      return [
        SliverPersistentHeader(
          delegate: Header(
            banner: block.image,
            placeholder: block.description,
            onScan: _onScan,
          ),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<ConfigsBloc, ConfigsState>(
            builder: (context, state) {
              List<BookingEntity> items = [];
              if (state is ConfigsSuccess) {
                items = block.services.map((e) {
                  return state.config.bookings[e]!;
                }).toList();
              }
              return ServicesBlock(
                items: items,
                onPressed: _onBooking,
              );
            },
          ),
        )
      ];
    } else if (block is BlockOffersEntity) {
      return [
        SliverToBoxAdapter(
          child: OffersBlock(
            data: block,
            onPressed: _onOffer,
          ),
        )
      ];
    } else {
      return [
        SliverToBoxAdapter(
          child: SizedBox.shrink(),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          List<Widget> blocks = [
            SliverPersistentHeader(
              delegate: Header(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ServicesBlock(),
            ),
            SliverToBoxAdapter(
              child: OffersBlock(),
            )
          ];
          if (state is HomeSuccess) {
            blocks = state.data
                .map(_buildBlock)
                .expand((sublist) => sublist)
                .toList();
          }

          return RefreshIndicator(
            edgeOffset: 246,
            onRefresh: () async {},
            child: CustomScrollView(
              slivers: blocks,
            ),
          );
        },
      ),
    );
  }
}
