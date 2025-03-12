import 'package:booking/presentation/presentation.dart';

import 'shared.dart';

class DefaultDetail extends StatefulWidget {
  const DefaultDetail({super.key});

  @override
  State<DefaultDetail> createState() => _DefaultDetailState();
}

class _DefaultDetailState extends State<DefaultDetail> with ProductDetailBase {}
