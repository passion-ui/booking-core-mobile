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
      return Hotel(
        data: data as HotelEntity,
        onPressed: onPressed as Function(HotelEntity)?,
        style: style,
        currency: currency,
      );
    } else {
      return Container(
        width: 120,
        height: 120,
        color: Colors.red,
      );
    }
  }
}
