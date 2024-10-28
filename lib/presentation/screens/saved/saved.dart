import 'package:booking/presentation/presentation.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('saved'),
            ),
            pinned: true,
          ),
        ],
      ),
    );
  }
}
