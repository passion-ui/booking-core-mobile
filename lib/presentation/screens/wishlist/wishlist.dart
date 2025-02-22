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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///Handle load more
  void _onScroll() async {
    if (_scrollController.position.extentAfter > 100) return;
    final wishlist = context.read<WishListCubit>().state;
    if (wishlist is WishListSuccess && wishlist.data.allowMore && !_fetching) {
      _fetching = true;
      context.read<WishListCubit>().onLoad(isLoadMore: true);
    }
  }

  ///On Refresh
  Future<void> _onRefresh() async {
    await context.read<WishListCubit>().onLoad();
  }

  /// Login
  void _onLogin() {
    context.push(Routers.login);
  }

  ///On Listing
  void _onListing(ProductEntity item) {
    context.push(Routers.productDetail, extra: item);
  }

  void _onAction(ProductEntity item) async {
    final data = await showModalBottomSheet<PickerEntity>(
      context: context,
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
      switch (data.id) {
        case 'delete':
          context.read<WishListCubit>().onUpdateItem(item);
          break;
        case 'share':
          context
              .read<MessageBloc>()
              .add(OnMessage(title: "TODO Action ${data.id}"));
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, authentication) {
            if (authentication is AuthenticationSuccess) {
              _onRefresh();
            }
          },
        ),
        BlocListener<WishListCubit, WishListState>(
          listener: (context, wishlist) {
            if (wishlist is WishListSuccess) {
              _fetching = false;
            }
          },
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authentication) {
          List<Widget> actions = [];

          if (authentication is AuthenticationSuccess) {
            actions = [
              IconButton(
                enableFeedback: true,
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  context
                      .read<MessageBloc>()
                      .add(OnMessage(title: "TODO Action delete all"));
                },
              ),
            ];
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                Translate.of(context).translate('wishlist'),
              ),
              actions: actions,
            ),
            body: BlocBuilder<WishListCubit, WishListState>(
              builder: (context, wishlist) {
                /// Not login
                if (authentication is AuthenticationFail) {
                  return Empty(
                    message: Translate.of(context).translate(
                      'sign_in_to_continue_saved',
                    ),
                    action: Translate.of(context).translate('login'),
                    onAction: _onLogin,
                  );
                }

                /// Success
                if (wishlist is WishListSuccess) {
                  /// Empty list
                  if (wishlist.data.items.isEmpty) {
                    return Empty(
                      message: Translate.of(context).translate(
                        'wishlist_is_empty',
                      ),
                      action: Translate.of(context).translate('refresh'),
                      onAction: _onRefresh,
                    );
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

                  /// List data
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                }

                /// Loading
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
              },
            ),
          );
        },
      ),
    );
  }
}
