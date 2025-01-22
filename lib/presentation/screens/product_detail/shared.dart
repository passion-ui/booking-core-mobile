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

  void onMessage() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action delete all"));
  }

  void onShare(ProductEntity item) {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action share"));
  }

  void onMap(ProductEntity item) {
    context.push(Routers.maps, extra: item.gps);
  }

  void onGallery(ProductEntity item) {
    context.push(Routers.gallery, extra: item);
  }

  void onFavorite() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action favorite"));
  }

  Widget buildTitle(ProductEntity item) {
    return Text(
      item.title,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surfaceContainerLowest;
    return Scaffold(
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        bloc: _productDetailCubit,
        builder: (context, state) {
          List<Widget> actions = [];
          Widget banner = Skeleton(child: Container(color: Colors.white));
          Widget title = Skeleton(
            child: Container(height: 16, color: Colors.white),
          );
          Widget feature = Container();
          Widget rating = Skeleton(
            child: Container(height: 16, width: 150, color: Colors.white),
          );
          Widget location = Skeleton(
            child: Container(height: 12, width: 100, color: Colors.white),
          );
          Widget description = Skeleton(
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
          );
          Color? iconColor;
          if (_iconBackground == Colors.black26) {
            iconColor = Colors.white;
          }

          if (state is ProductDetailSuccess) {
            ///Actions
            actions = [
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

            ///Banner
            banner = CachedImage(url: state.product.banner!);
            if (state.product.video != null) {
              banner = Video(
                url: state.product.video!,
                preview: state.product.banner!,
              );
            }

            ///Title
            title = buildTitle(state.product);

            ///Feature
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

            ///Location
            location = Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cardColor,
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

            ///Rating
            rating = Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    '${state.product.review.score}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  state.product.review.text,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${state.product.review.total} ${Translate.of(context).translate('reviews')})',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );

            ///Description
            description = Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cardColor,
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
                actions: actions,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: banner,
                ),
                bottom: PreferredSize(
                  preferredSize: Size(0, 80),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 8,
                        bottom: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: title),
                          Row(
                            children: [
                              SizedBox(width: 8),
                              feature,
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          location,
                          const SizedBox(height: 12),
                          description,
                          Divider(),
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
