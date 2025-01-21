import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

mixin ProductDetailBase<T extends StatefulWidget> on State<T> {
  late ProductEntity item;
  final _scrollController = ScrollController();
  final _productDetailCubit = ProductDetailCubit();

  Color? _iconBackground = Colors.black12;

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
      background = Colors.black12;
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

  void onShare() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action share"));
  }

  void onMap() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action map"));
  }

  void onGallery() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action gallery"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        bloc: _productDetailCubit,
        builder: (context, state) {
          List<Widget> actions = [];
          Widget banner = Skeleton(
            child: Container(color: Colors.white),
          );
          Color? iconColor;
          if (_iconBackground == Colors.black12) {
            iconColor = Colors.white;
          }

          if (state is ProductDetailSuccess) {
            actions = [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: onShare,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_iconBackground),
                  iconColor: WidgetStateProperty.all(iconColor),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.map_outlined),
                onPressed: onMap,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_iconBackground),
                  iconColor: WidgetStateProperty.all(iconColor),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.photo_library_outlined),
                onPressed: onGallery,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(_iconBackground),
                  iconColor: WidgetStateProperty.all(iconColor),
                ),
              ),
              SizedBox(width: 4),
            ];
            banner = CachedImage(url: state.product.banner!);
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
              ),
              SliverToBoxAdapter(
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 1000,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
