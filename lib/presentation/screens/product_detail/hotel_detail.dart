import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class HotelDetail extends StatefulWidget {
  final HotelEntity item;

  const HotelDetail({super.key, required this.item});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> with ProductDetailBase {
  @override
  buildBanner(ProductDetailState state) {
    return Container(
      height: 200,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContent();
  }
}
