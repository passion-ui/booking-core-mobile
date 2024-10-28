import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                Images.logo,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 150),
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
