import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin ProductDetailBase<T extends StatefulWidget> on State<T> {
  late ProductEntity item;
  final _scrollController = ScrollController();
  final _productDetailCubit = ProductDetailCubit();

  Color? _iconBackground = Colors.black26;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _productDetailCubit.onLoadDetail(item);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productDetailCubit.close();
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
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action favorite"));
  }

  ///Build shared title
  Widget buildTitle(ProductEntity item) {
    return Text(
      item.title,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  ///Build action
  List<Widget> _buildActions(ProductDetailState state) {
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
  Widget _buildBanner(ProductDetailState state) {
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
  Widget _buildHeader(ProductDetailState state) {
    if (state is ProductDetailSuccess) {
      Widget feature = Container();
      if (state.product.isFeatured) {
        feature = Container(
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
        );
      }
      return Container(
        height: 68,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
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
            Expanded(child: buildTitle(state.product)),
            SizedBox(width: 12),
            Row(children: [
              feature,
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_outline),
              ),
            ]),
          ],
        ),
      );
    }

    ///Return skeleton
    return Container(
      height: 68,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Skeleton(
                child: Container(height: 12, width: 100, color: Colors.white),
              ),
              SizedBox(height: 8),
              Skeleton(
                child: Container(height: 16, width: 150, color: Colors.white),
              ),
            ],
          ),
          SizedBox(width: 12),
          Skeleton(
            child: Container(height: 24, width: 24, color: Colors.white),
          ),
        ],
      ),
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
              Translate.of(context).translate('hotel_information'),
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
            Text(
              Translate.of(context).translate('reviews'),
              style: Theme.of(context).textTheme.titleMedium,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        bloc: _productDetailCubit,
        builder: (context, state) {
          Color? iconColor;
          if (_iconBackground == Colors.black26) {
            iconColor = Colors.white;
          }

          if (state is ProductDetailSuccess) {
            ///Rating
            // rating = Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).colorScheme.primary,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(6),
            //           bottomLeft: Radius.circular(6),
            //           bottomRight: Radius.circular(6),
            //         ),
            //       ),
            //       child: Text(
            //         '${state.product.review.score}',
            //         style: Theme.of(context).textTheme.labelSmall?.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //       ),
            //     ),
            //     const SizedBox(width: 4),
            //     Text(
            //       state.product.review.text,
            //       style: Theme.of(context).textTheme.labelMedium?.copyWith(
            //             color: Theme.of(context).colorScheme.primary,
            //           ),
            //     ),
            //     const SizedBox(width: 4),
            //     Text(
            //       '(${state.product.review.total} ${Translate.of(context).translate('reviews')})',
            //       style: Theme.of(context).textTheme.bodySmall,
            //     ),
            //   ],
            // );
          }

          return CustomScrollView(
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
                expandedHeight: MediaQuery.of(context).size.height * 0.25,
                pinned: true,
                actions: _buildActions(state),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: _buildBanner(state),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(0, 80),
                  child: _buildHeader(state),
                ),
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
                          const SizedBox(height: 12),
                          _buildProperties(state),
                          const SizedBox(height: 12),
                          _buildReview(state),
                          Container(
                            height: 1000,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
