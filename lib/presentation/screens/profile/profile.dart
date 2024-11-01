import 'package:booking/presentation/presentation.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('profile'),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [Text("Saved List")],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
