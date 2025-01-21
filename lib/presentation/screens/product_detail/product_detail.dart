import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class ProductDetail extends StatefulWidget {
  final ProductEntity item;

  const ProductDetail({super.key, required this.item});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with ProductDetailBase {
  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
