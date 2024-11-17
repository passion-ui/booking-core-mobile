import 'package:booking/presentation/presentation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  final double value;
  final double size;
  final ValueChanged<double>? onRating;

  const Rating({
    super.key,
    this.value = 0.0,
    this.onRating,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: value,
      minRating: 1,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(100),
      itemCount: 5,
      itemSize: size,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (value) {
        onRating!(value);
      },
      ignoreGestures: onRating == null,
    );
  }
}
