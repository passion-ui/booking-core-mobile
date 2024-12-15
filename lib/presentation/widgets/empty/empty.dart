import 'package:booking/core/core.dart';
import 'package:booking/presentation/presentation.dart';

class Empty extends StatelessWidget {
  final String? image;
  final String message;
  final String action;
  final VoidCallback onAction;

  const Empty({
    super.key,
    this.image,
    required this.message,
    required this.action,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image ?? Images.waiting,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onAction,
            child: Text(
              action,
            ),
          ),
        ],
      ),
    );
  }
}
