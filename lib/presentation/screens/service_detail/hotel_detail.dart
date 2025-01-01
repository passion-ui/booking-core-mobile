import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class HotelDetail extends StatefulWidget {
  final HotelEntity item;

  const HotelDetail({super.key, required this.item});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> with ProductDetailBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('hotel_detail'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.domain,
                        color: Colors.cyan,
                      ),
                    ),
                    title: Translate.of(context).translate('hotel_detail'),
                    onPress: onMessage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
