import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ListingItem extends StatelessWidget {
  final ProductEntity? data;
  final Function(ProductEntity)? onPressed;
  final Function(ProductEntity)? onAction;
  final ListingViewStyle style;
  final String? currency;

  const ListingItem({
    super.key,
    this.data,
    this.onPressed,
    this.onAction,
    required this.style,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    if (data is HotelEntity) {
      return HotelItem(
        data: data as HotelEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else if (data is TourEntity) {
      return TourItem(
        data: data as TourEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else if (data is SpaceEntity) {
      return SpaceItem(
        data: data as SpaceEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else if (data is EventEntity) {
      return EventItem(
        data: data as EventEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else if (data is BoatEntity) {
      return BoatItem(
        data: data as BoatEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else if (data is CarEntity) {
      return CarItem(
        data: data as CarEntity,
        onPressed: onPressed,
        onAction: onAction,
        style: style,
        currency: currency,
      );
    } else {
      return HotelItem(style: style);
    }
  }
}
