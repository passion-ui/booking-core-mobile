import 'package:booking/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;

  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Skeleton(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).hoverColor,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Theme.of(context).colorScheme.errorContainer,
          ),
          child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
        );
      },
    );
  }
}
