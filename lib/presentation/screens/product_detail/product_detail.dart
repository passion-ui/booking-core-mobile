import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

mixin ProductDetailBase<T extends StatefulWidget> on State<T> {
  final _scrollController = ScrollController();
  final _productDetailCubit = ProductDetailCubit();
  Color? _iconBackground = Colors.black12;

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

  Widget buildBanner(ProductDetailState state) {
    return Container(
      alignment: Alignment.center,
      child: Text("Banner"),
    );
  }

  Widget buildContent() {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      bloc: _productDetailCubit,
      builder: (context, state) {
        List<Widget> action = [];
        Color? iconColor;
        if (_iconBackground == Colors.black12) {
          iconColor = Colors.white;
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
              actions: action,
              flexibleSpace: buildBanner(state),
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
    );
  }
}

class ProductDetail extends StatefulWidget {
  final ProductEntity item;

  const ProductDetail({super.key, required this.item});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with ProductDetailBase {
  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}
