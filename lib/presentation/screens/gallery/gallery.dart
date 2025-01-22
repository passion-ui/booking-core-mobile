import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatefulWidget {
  final ProductEntity product;
  const Gallery({super.key, required this.product});

  @override
  State<Gallery> createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  final _controller = SwiperController();
  final _listController = ScrollController();

  PageController _pageController = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _listController.dispose();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  ///On preview photo
  void _onPreviewPhoto(int index) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return PhotoViewGallery.builder(
          loadingBuilder: (context, event) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget.product.gallery.length,
          pageController: _pageController,
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }

  ///On select image
  void _onSelectImage(int index) {
    _controller.move(index);
  }

  ///On Process index change
  void _onChange(int index) {
    setState(() {
      _index = index;
    });
    _pageController = PageController(initialPage: _index);
    final currentOffset = (index + 1) * 90.0;
    final widthDevice = MediaQuery.of(context).size.width;

    ///Animate scroll to Overflow offset
    if (currentOffset > widthDevice) {
      _listController.animateTo(
        currentOffset - widthDevice,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      ///Move to Start offset when index not overflow
      _listController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  ///Build Item
  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.product.gallery[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 1.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                controller: _controller,
                onIndexChanged: _onChange,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onPreviewPhoto(index);
                    },
                    child: CachedImage(
                      url: widget.product.gallery[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: widget.product.gallery.length,
                pagination: const SwiperPagination(
                  alignment: Alignment(0.0, 0.9),
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "${_index + 1}/${widget.product.gallery.length}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListView.builder(
                controller: _listController,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.gallery.length,
                itemBuilder: (context, index) {
                  Color color = Colors.transparent;
                  final item = widget.product.gallery[index];
                  if (index == _index) {
                    color = Theme.of(context).colorScheme.primary;
                  }

                  return GestureDetector(
                    onTap: () {
                      _onSelectImage(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedImage(
                        url: item,
                        width: 80,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
