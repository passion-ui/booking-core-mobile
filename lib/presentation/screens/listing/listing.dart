import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class DefaultListing extends StatefulWidget {
  const DefaultListing({super.key});

  @override
  State<DefaultListing> createState() => _DefaultListingState();
}

class _DefaultListingState extends State<DefaultListing> with ListingBase {}

class Listing extends StatelessWidget {
  final BookingEntity item;

  const Listing({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Widget child = DefaultListing();
    if (item.id == 'hotel') {
    } else if (item.name == 'tour') {
    } else if (item.name == 'space') {
    } else if (item.name == 'car') {
    } else if (item.name == 'event') {
    } else if (item.name == 'boat') {}

    return BlocProvider(
      create: (context) => ListingCubit(item: item),
      child: child,
    );
  }
}
