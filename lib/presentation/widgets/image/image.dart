import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCached extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const ImageCached({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
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
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return CircularProgressIndicator();
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
    );
  }
}
