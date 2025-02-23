import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin ProductDetailBase<T extends StatefulWidget> on State<T> {
  late ProductEntity item;
  ProductDetailCubit? productDetailCubit;
  final _scrollController = ScrollController();

  Color? _iconBackground = Colors.black26;

  @override
  void initState() {
    super.initState();
    productDetailCubit ??= ProductDetailCubit();
    _scrollController.addListener(_onScroll);
    productDetailCubit?.onLoadDetail(item);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    productDetailCubit?.close();
    super.dispose();
  }

  ///Handle icon theme
  void _onScroll() {
    Color? background;
    if (_scrollController.position.extentBefore < 110) {
      background = Colors.black26;
    }
    if (background != _iconBackground) {
      setState(() {
        _iconBackground = background;
      });
    }
  }

  ///Handle share action
  void onShare(ProductEntity item) {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action share"));
  }

  ///Handle map action
  void onMap(ProductEntity item) {
    context.push(Routers.maps, extra: item.gps);
  }

  ///Handle gallery action
  void onGallery(ProductEntity item) {
    context.push(Routers.gallery, extra: item);
  }

  ///Handle favorite action
  void onFavorite() {
    Routers().ensureAuthentication(context, action: () {
      context.read<WishListCubit>().onUpdateItem(item);
    });
  }

  ///On Detail
  void onDetail(ProductEntity item) {
    context.push(Routers.productDetail, extra: item);
  }

  ///Handle review list
  void onReview() {
    context.push(Routers.review, extra: item);
  }

  void onCart() {
    context.push(Routers.cart, extra: productDetailCubit);
  }

  ///Get header height
  double getHeaderHeight() {
    return MediaQuery.of(context).size.height * 0.26;
  }

  ///Build shared content
  Widget buildContent(ProductDetailState state) {
    return SizedBox.shrink();
  }

  ///Build footer actions
  Widget? buildFooterActions(ProductDetailState state) {
    return null;
  }

  ///Build action
  List<Widget> buildActions(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      Color? iconColor;
      if (_iconBackground == Colors.black26) {
        iconColor = Colors.white;
      }
      return [
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => onShare(state.product),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_iconBackground),
            iconColor: WidgetStateProperty.all(iconColor),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.map_outlined),
          onPressed: () => onMap(state.product),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_iconBackground),
            iconColor: WidgetStateProperty.all(iconColor),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.photo_library_outlined),
          onPressed: () => onGallery(state.product),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_iconBackground),
            iconColor: WidgetStateProperty.all(iconColor),
          ),
        ),
        SizedBox(width: 4),
      ];
    }

    return [];
  }

  ///Build banner
  Widget buildBanner(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      Widget banner = CachedImage(url: state.product.banner!);
      if (state.product.video != null) {
        banner = Video(
          url: state.product.video!,
          preview: state.product.banner!,
        );
      }
      return banner;
    }

    return Skeleton(child: Container(color: Colors.white));
  }

  ///Build header
  PreferredSizeWidget buildHeader(ProductDetailState state) {
    Widget content = Container(
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Skeleton(
            child: Container(height: 16, width: 250, color: Colors.white),
          ),
          SizedBox(width: 12),
          Skeleton(
            child: Container(
              height: 32,
              width: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    if (state is ProductDetailSuccess) {
      Widget feature = Container();
      if (state.product.isFeatured) {
        feature = Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Translate.of(context).translate('featured'),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(width: 8),
          ],
        );
      }

      content = Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(20),
              offset: Offset(0, 2),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 12),
            Row(children: [
              feature,
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: onFavorite,
                  icon: Icon(Icons.favorite_outline),
                ),
              ),
            ]),
          ],
        ),
      );
    }

    return PreferredSize(
      preferredSize: Size(0, 72),
      child: content,
    );
  }

  ///Build location
  Widget _buildLocation(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translate.of(context).translate('location'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  state.product.address,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 160,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.product.gps?.latitude ?? 40.697403,
                    state.product.gps?.longitude ?? -74.1201063,
                  ),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(state.product.title),
                    position: LatLng(
                      state.product.gps?.latitude ?? 40.697403,
                      state.product.gps?.longitude ?? -74.1201063,
                    ),
                  ),
                },
                myLocationButtonEnabled: false,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Build description
  Widget _buildDescription(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translate.of(context).translate('information'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            HtmlWidget(state.product.content)
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeleton(
        child: Column(
          children: [
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }

  ///Build properties
  Widget _buildProperties(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      final properties = state.product.properties;
      return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: properties?.length ?? 0,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (context, index) {
          final property = properties![index];
          final ratio = (MediaQuery.of(context).size.width / 2) / 20;
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translate.of(context).translate(
                    property.parent.title,
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: ratio,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: property.children.length,
                  itemBuilder: (context, index) {
                    final child = property.children[index];
                    return Row(
                      children: [
                        Icon(
                          IconFactory.get(
                            child.slug,
                            defaultIcon: Icons.check_circle_outline,
                          ),
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            Translate.of(context).translate(child.title),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    ///Return skeleton
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeleton(
        child: Column(
          children: [
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }

  ///Build review
  Widget _buildReview(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translate.of(context).translate('reviews'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                  onTap: onReview,
                  child: Text(
                    Translate.of(context).translate('see_more'),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${state.product.review.score}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            ' /5',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(${state.product.review.total} ${Translate.of(context).translate('reviews')})',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: VerticalDivider(),
                ),
                Expanded(
                  flex: 7,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.product.review.rateScore?.length ?? 0,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 4);
                    },
                    itemBuilder: (context, index) {
                      final item = state.product.review.rateScore![index];
                      return Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              Translate.of(context).translate(
                                item.title,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Container(
                              height: 6,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Theme.of(context).splashColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: item.percent * 0.01,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = state.product.feedbacks![index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).splashColor,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Paul",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Rating(
                                    value: item.rateNumber.toDouble(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            item.createdAt.viewTime(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.content,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemCount: state.product.feedbacks?.length ?? 0,
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Skeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }

  ///Build FAQ
  Widget _buildFaq(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      if (state.product.faqs?.isNotEmpty == true) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context).translate('faqs'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = state.product.faqs![index];
                      return ExpansionTile(
                        tilePadding: EdgeInsets.symmetric(horizontal: 12),
                        childrenPadding: EdgeInsets.zero,
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).splashColor,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                        title: Text(
                          item.title,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              item.content,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: state.product.faqs?.length ?? 0,
                  )
                ],
              ),
            ),
          ],
        );
      }
    }

    return Container();
  }

  ///Build related
  Widget _buildRelated(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      String currency = '';

      final config = context.read<ConfigsBloc>().state;
      if (config is ConfigsSuccess) {
        currency = config.data.currency.symbol;
      }
      if (state.product.related?.isNotEmpty == true) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translate.of(context).translate('related'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 260,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = state.product.related![index];
                        return ListingItem(
                          data: item,
                          onPressed: onDetail,
                          style: ListingViewStyle.card,
                          currency: currency,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 8);
                      },
                      itemCount: state.product.related!.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: productDetailCubit,
      builder: (context, state) {
        Color? iconColor;
        if (_iconBackground == Colors.black26) {
          iconColor = Colors.white;
        }
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                leading: BackButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(_iconBackground),
                    iconColor: WidgetStateProperty.all(iconColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: getHeaderHeight(),
                pinned: true,
                actions: buildActions(state),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: buildBanner(state),
                ),
                bottom: buildHeader(state),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLocation(state),
                          const SizedBox(height: 12),
                          _buildDescription(state),
                          buildContent(state),
                          const SizedBox(height: 12),
                          _buildProperties(state),
                          const SizedBox(height: 12),
                          _buildReview(state),
                          _buildFaq(state),
                          _buildRelated(state),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
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
              children: [buildFooterActions(state) ?? Container()],
            ),
          ),
        );
      },
    );
  }
}
