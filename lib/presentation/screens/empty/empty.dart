import 'package:booking/presentation/presentation.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('settings'),
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
                    title: Translate.of(context).translate('settings'),
                    onPress: () {},
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
