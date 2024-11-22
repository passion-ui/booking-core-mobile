import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ListingItem extends StatelessWidget {
  final ListingEntity? data;
  final Function(ListingEntity)? onPressed;
  final ListingViewStyle style;
  final String? currency;

  const ListingItem({
    super.key,
    this.data,
    this.onPressed,
    required this.style,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    if (data is HotelEntity) {
      return HotelItem(
        data: data as HotelEntity,
        onPressed: onPressed as Function(HotelEntity)?,
        style: style,
        currency: currency,
      );
    } else if (data is TourEntity) {
      return TourItem(
        data: data as TourEntity,
        onPressed: onPressed,
        style: style,
        currency: currency,
      );
    } else if (data is SpaceEntity) {
      return SpaceItem(
        data: data as SpaceEntity,
        onPressed: onPressed,
        style: style,
        currency: currency,
      );
    } else if (data is CarEntity) {
      return Container(
        width: 200,
        height: 200,
        color: Colors.red,
      );
    } else if (data is EventEntity) {
      return EventItem(
        data: data as EventEntity,
        onPressed: onPressed,
        style: style,
        currency: currency,
      );
    } else if (data is BoatEntity) {
      return BoatItem(
        data: data as BoatEntity,
        onPressed: onPressed,
        style: style,
        currency: currency,
      );
    } else {
      return HotelItem(style: ListingViewStyle.normal);
    }
  }
}
