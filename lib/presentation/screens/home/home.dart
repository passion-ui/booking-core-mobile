import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'bestseller.dart';
import 'header.dart';
import 'location.dart';
import 'offers.dart';
import 'services.dart';
import 'space.dart';
import 'tour.dart';

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

  ///On Best Seller
  void _onListing(ListingEntity item) {
    context.go(Routers.listing);
  }

  ///On Location
  void _onLocation(LocationEntity item) {
    context.go(Routers.listing);
  }

  ///Build block
  List<Widget> _buildBlock(BlockHomeEntity block) {
    if (block is BlockServiceEntity) {
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
                  return state.data.bookings[e]!;
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
    } else if (block is BlockOfferEntity) {
      return [
        SliverToBoxAdapter(
          child: OffersBlock(
            data: block,
            onPressed: _onOffer,
          ),
        )
      ];
    } else if (block is BlockBestSellerEntity) {
      return [
        SliverToBoxAdapter(
          child: BestSellerBlock(
            data: block,
            onPressed: _onListing,
          ),
        )
      ];
    } else if (block is BlockLocationEntity) {
      return [
        SliverToBoxAdapter(
          child: LocationBlock(
            data: block,
            onPressed: _onLocation,
          ),
        )
      ];
    } else if (block is BlockTourEntity) {
      return [
        SliverToBoxAdapter(
          child: TourBlock(
            data: block,
            onPressed: _onListing,
          ),
        )
      ];
    } else if (block is BlockSpaceEntity) {
      return [
        SliverToBoxAdapter(
          child: SpaceBlock(
            data: block,
            onPressed: _onListing,
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
        builder: (context, home) {
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
            ),
            SliverToBoxAdapter(
              child: BestSellerBlock(),
            ),
            SliverToBoxAdapter(
              child: TourBlock(),
            )
          ];
          if (home is HomeSuccess) {
            blocks = home.data
                .map(_buildBlock)
                .expand((sublist) => sublist)
                .toList();
          }

          return RefreshIndicator(
            edgeOffset: 246,
            onRefresh: () async {},
            child: CustomScrollView(
              slivers: [
                ...blocks,
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
