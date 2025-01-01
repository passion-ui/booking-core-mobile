import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

mixin ProductDetailBase<T extends StatefulWidget> on State<T> {
  void onMessage() {
    context.read<MessageBloc>().add(OnMessage(title: "TODO Action delete all"));
  }
}

class ServiceDetail extends StatefulWidget {
  final ProductEntity item;

  const ServiceDetail({super.key, required this.item});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> with ProductDetailBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('service_detail'),
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
                    title: Translate.of(context).translate('service_detail'),
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
