import 'package:booking/presentation/presentation.dart';

class Steps extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const Steps({
    super.key,
    required this.value,
    required this.onChanged,
  });

  void _increment() {
    onChanged(value + 1);
  }

  void _decrement() {
    onChanged(value - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _decrement,
        ),
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '$value',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _increment,
        ),
      ],
    );
  }
}
