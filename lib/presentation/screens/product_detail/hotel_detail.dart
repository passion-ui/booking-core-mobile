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
}
