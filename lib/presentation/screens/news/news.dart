import 'package:booking/presentation/presentation.dart';

class News extends StatelessWidget {
  const News({super.key});

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
              Translate.of(context).translate('news'),
            ),
            pinned: true,
          ),
        ],
      ),
    );
  }
}
