import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'boat_detail.dart';
import 'car_detail.dart';
import 'event_detail.dart';
import 'hotel_detail.dart';
import 'space_detail.dart';
import 'tour_detail.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntity item;

  const ProductDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item is HotelEntity) {
      return HotelDetail(item: item as HotelEntity);
    } else if (item is TourEntity) {
      return TourDetail(item: item as TourEntity);
    } else if (item is SpaceEntity) {
      return SpaceDetail(item: item as SpaceEntity);
    } else if (item is CarEntity) {
      return CarDetail(item: item as CarEntity);
    } else if (item is EventEntity) {
      return EventDetail(item: item as EventEntity);
    } else if (item is BoatEntity) {
      return BoatDetail(item: item as BoatEntity);
    } else {
      return ProductDetail(item: item);
    }
  }
}
