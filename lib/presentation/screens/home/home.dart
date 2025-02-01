import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'banner.dart';
import 'bestseller.dart';
import 'boat.dart';
import 'car.dart';
import 'event.dart';
import 'header.dart';
import 'location.dart';
import 'offer.dart';
import 'post.dart';
import 'products.dart';
import 'space.dart';
import 'tour.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeCubit = HomeCubit();

  @override
  void initState() {
    super.initState();
    _homeCubit.onLoad();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  ///On Refresh
  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().onLoad();
  }

  ///On Search
  void _onSearch() {
    context.push(Routers.search);
  }

  ///On Scan
  void _onScan() {
    context.push(Routers.scanQR);
  }

  ///On Booking
  void _onListing(BookingEntity item) {
    context.push(Routers.listing);
  }

  ///On Offer
  void _onOffer(BannerEntity item) {}

  ///On Detail
  void _onDetail(ProductEntity item) {
    context.push(Routers.productDetail, extra: item);
  }

  ///On New
  void _onNew(PostEntity item) {
    context.push(Routers.detailNew);
  }

  ///On Location
  void _onLocation(CategoryEntity item) {
    context.push(Routers.listing);
  }

  ///Build block
  List<Widget> _buildBlock(BlockHomeEntity block) {
    if (block is BlockProductEntity) {
      return [
        SliverPersistentHeader(
          delegate: Header(
            banner: block.image,
            placeholder: block.description,
            onScan: _onScan,
            onSearch: _onSearch,
            minHeight: MediaQuery.of(context).padding.top + 62,
            maxHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<ConfigsBloc, ConfigsState>(
            builder: (context, state) {
              List<BookingEntity> items = [];
              if (state is ConfigsSuccess) {
                items = block.products.map((e) {
                  return state.data.bookings[e]!;
                }).toList();
              }
              return ProductsBlock(
                items: items,
                onPressed: _onListing,
              );
            },
          ),
        )
      ];
    } else if (block is BlockOfferEntity) {
      return [
        SliverToBoxAdapter(
          child: OfferBlock(
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
            onPressed: _onDetail,
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
            onPressed: _onDetail,
          ),
        )
      ];
    } else if (block is BlockSpaceEntity) {
      return [
        SliverToBoxAdapter(
          child: SpaceBlock(
            data: block,
            onPressed: _onDetail,
          ),
        )
      ];
    } else if (block is BlockCarEntity) {
      return [
        SliverToBoxAdapter(
          child: CarBlock(
            data: block,
            onPressed: _onDetail,
          ),
        )
      ];
    } else if (block is BlockEventEntity) {
      return [
        SliverToBoxAdapter(
          child: EventBlock(
            data: block,
            onPressed: _onDetail,
          ),
        )
      ];
    } else if (block is BlockBoatEntity) {
      return [
        SliverToBoxAdapter(
          child: BoatBlock(
            data: block,
            onPressed: _onDetail,
          ),
        )
      ];
    } else if (block is BlockPostEntity) {
      return [
        SliverToBoxAdapter(
          child: PostBlock(
            data: block,
            onPressed: _onNew,
          ),
        )
      ];
    } else if (block is BlockBannerEntity) {
      return [
        SliverToBoxAdapter(
          child: BannerBlock(
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
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
        builder: (context, home) {
          List<Widget> blocks = [
            SliverPersistentHeader(
              delegate: Header(
                onSearch: _onSearch,
                minHeight: MediaQuery.of(context).padding.top + 62,
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ProductsBlock(),
            ),
            SliverToBoxAdapter(
              child: OfferBlock(),
            ),
            SliverToBoxAdapter(
              child: BestSellerBlock(),
            ),
            SliverToBoxAdapter(
              child: TourBlock(),
            ),
            SliverToBoxAdapter(
              child: SpaceBlock(),
            )
          ];
          if (home is HomeSuccess) {
            if (home.data.isEmpty) {
              blocks = [
                SliverFillRemaining(
                  child: Empty(
                    message: Translate.of(context).translate(
                      'your_data_is_empty',
                    ),
                    action: Translate.of(context).translate('refresh'),
                    onAction: _onRefresh,
                  ),
                )
              ];
            } else {
              blocks = home.data
                  .map(_buildBlock)
                  .expand((sublist) => sublist)
                  .toList();
            }
          }

          return RefreshIndicator(
            edgeOffset: 246,
            onRefresh: _onRefresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
