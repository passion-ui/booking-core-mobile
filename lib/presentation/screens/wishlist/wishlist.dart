import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final _scrollController = ScrollController();
  bool _fetching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final auth = context.read<AuthenticationBloc>();
    if (auth.state is AuthenticationSuccess) {
      context.read<WishListBloc>().add(OnLoadWishList());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///Handle load more
  void _onScroll() async {
    if (_scrollController.position.extentAfter > 100) return;
    final wishlist = context.read<WishListBloc>().state;
    if (wishlist is WishListSuccess && wishlist.data.allowMore && !_fetching) {
      _fetching = true;
      context.read<WishListBloc>().add(OnLoadWishList(isLoadMore: true));
    }
  }

  /// Login
  void _onLogin() {
    context.go(Routers.login);
  }

  ///On Listing
  void _onListing(ProductEntity item) {
    context.go(Routers.listing);
  }

  void _onAction(ProductEntity item) async {
    final data = await showModalBottomSheet<PickerEntity>(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return BottomSheetAction(
          title: Translate.of(context).translate('wishlist'),
          items: [
            PickerEntity(
              id: 'delete',
              leading: Icon(Icons.delete_outline),
              title: Translate.of(context).translate('delete'),
            ),
            PickerEntity(
              id: 'share',
              leading: Icon(Icons.share),
              title: Translate.of(context).translate('share'),
            )
          ],
        );
      },
    );

    if (data != null && mounted) {
      context
          .read<MessageBloc>()
          .add(OnMessage(title: "TODO Action ${data.id}"));
      switch (data.id) {
        case 'delete':
          break;
        case 'share':
          break;
      }
    }
  }

  /// Build Authentication
  Widget _buildAuthentication() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              Images.waiting,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            Text(
              Translate.of(context).translate(
                'sign_in_to_continue_saved',
              ),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _onLogin,
              child: Text(
                Translate.of(context).translate('login'),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  /// Build Empty
  Widget _buildEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              Images.waiting,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            Text(
              Translate.of(context).translate(
                'wishlist_is_empty',
              ),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('wishlist'),
        ),
        actions: [
          IconButton(
            enableFeedback: true,
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              context
                  .read<MessageBloc>()
                  .add(OnMessage(title: "TODO Action delete all"));
            },
          ),
        ],
      ),
      body: BlocConsumer<WishListBloc, WishListState>(
        listener: (context, wishlist) {
          if (wishlist is WishListSuccess) {
            _fetching = false;
          }
        },
        builder: (context, wishlist) {
          return BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, authentication) {
              if (authentication is AuthenticationSuccess) {
                context.read<WishListBloc>().add(OnLoadWishList());
              }
            },
            builder: (context, authentication) {
              /// Need Authentication
              if (authentication is AuthenticationFail) {
                return _buildAuthentication();
              }

              if (wishlist is WishListSuccess) {
                /// Empty list
                if (wishlist.data.items.isEmpty) {
                  return _buildEmpty();
                }
                String currency = '';
                List list = List.from(wishlist.data.items);
                if (wishlist.data.allowMore) {
                  list.add(null);
                }

                final config = context.read<ConfigsBloc>().state;
                if (config is ConfigsSuccess) {
                  currency = config.data.currency.symbol;
                }

                /// List
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<WishListBloc>().add(OnLoadWishList());
                  },
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemBuilder: (context, index) {
                      final product = list[index];
                      if (product == null) {
                        return ListingItem(style: ListingViewStyle.list);
                      }
                      return ListingItem(
                        data: product.item,
                        style: ListingViewStyle.list,
                        onPressed: _onListing,
                        onAction: _onAction,
                        currency: currency,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                  ),
                );
              } else {
                /// Skeleton Loading
                return ListView.separated(
                  itemCount: 15,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemBuilder: (context, index) {
                    return ListingItem(style: ListingViewStyle.list);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
