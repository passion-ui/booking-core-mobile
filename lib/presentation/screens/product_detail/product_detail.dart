import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'boat_detail.dart';
import 'car_detail.dart';
import 'default_detail.dart';
import 'event_detail.dart';
import 'hotel_detail.dart';
import 'space_detail.dart';
import 'tour_detail.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntity item;

  const ProductDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Widget child = DefaultDetail();
    if (item is HotelEntity) {
      child = HotelDetail();
    } else if (item is TourEntity) {
      child = TourDetail();
    } else if (item is SpaceEntity) {
      child = SpaceDetail();
    } else if (item is CarEntity) {
      child = CarDetail();
    } else if (item is EventEntity) {
      child = EventDetail();
    } else if (item is BoatEntity) {
      child = BoatDetail();
    } else {
      child = DefaultDetail();
    }

    return BlocProvider(
      create: (context) => ProductDetailCubit(product: item),
      child: child,
    );
  }
}
