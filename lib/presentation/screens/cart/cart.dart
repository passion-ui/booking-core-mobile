import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'boat.dart';
import 'car.dart';
import 'event.dart';
import 'hotel.dart';
import 'space.dart';
import 'tour.dart';

class Cart extends StatelessWidget {
  final ProductDetailCubit productDetailCubit;

  const Cart({super.key, required this.productDetailCubit});

  @override
  Widget build(BuildContext context) {
    if (productDetailCubit.product is HotelEntity) {
      return HotelCart(cubit: productDetailCubit);
    } else if (productDetailCubit.product is TourEntity) {
      return TourCart(cubit: productDetailCubit);
    } else if (productDetailCubit.product is SpaceEntity) {
      return SpaceCart(cubit: productDetailCubit);
    } else if (productDetailCubit.product is CarEntity) {
      return CarCart(cubit: productDetailCubit);
    } else if (productDetailCubit.product is EventEntity) {
      return EventCart(cubit: productDetailCubit);
    } else if (productDetailCubit.product is BoatEntity) {
      return BoatCart(cubit: productDetailCubit);
    }

    return const Placeholder();
  }
}
