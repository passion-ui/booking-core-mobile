import 'package:booking/presentation/presentation.dart';

import 'hotel.dart';
import 'space.dart';
import 'tour.dart';

class Cart extends StatelessWidget {
  final ProductDetailCubit productDetailCubit;

  const Cart({super.key, required this.productDetailCubit});

  @override
  Widget build(BuildContext context) {
    if (productDetailCubit is HotelDetailCubit) {
      return HotelCart(cubit: productDetailCubit as HotelDetailCubit);
    } else if (productDetailCubit is TourDetailCubit) {
      return TourCart(cubit: productDetailCubit as TourDetailCubit);
    } else if (productDetailCubit is SpaceDetailCubit) {
      return SpaceCart(cubit: productDetailCubit as SpaceDetailCubit);
    }

    return const Placeholder();
  }
}
