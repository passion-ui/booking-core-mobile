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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Rating(value: 5),
        Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
