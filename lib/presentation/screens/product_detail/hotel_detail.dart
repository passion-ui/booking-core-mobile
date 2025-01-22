import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class HotelDetail extends StatefulWidget {
  final HotelEntity item;

  const HotelDetail({super.key, required this.item});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> with ProductDetailBase {
  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  @override
  Widget buildTitle(ProductEntity item) {
    final product = item as HotelEntity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Rating(
          value: product.point ?? 0.0,
          size: 16,
        ),
        const SizedBox(height: 2),
        Text(
          product.title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
