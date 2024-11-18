import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class LocationItem extends StatelessWidget {
  final ListingEntity? data;
  final Function(ListingEntity)? onPressed;
  final ListingViewStyle style;

  const LocationItem({
    super.key,
    this.data,
    this.onPressed,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Placeholder();
    }

    return Box(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => onPressed!(data!),
        child: SizedBox(
          width: 140,
          height: 220,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedImage(url: data!.image),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  data!.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
