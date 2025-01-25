import 'package:booking/presentation/presentation.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('feedback')),
      ),
      body: Center(
        child: Text('Feedback'),
      ),
    );
  }
}
