import 'package:booking/presentation/presentation.dart';

mixin ListingBase<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildHeader(ListingState state) {
    if (state is ListingSuccess) {
      final cubit = context.read<ListingCubit>();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    cubit.item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
              Text(
                "1000 Hotels",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.map_outlined,
            ),
          )
        ],
      );
    }

    return Container();
  }

  Widget buildHeaderAction(ListingState state) {
    return Container();
  }

  Widget buildContent(ListingState state) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingCubit, ListingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: buildHeader(state),
            titleSpacing: 0,
          ),
          body: Column(
            children: [
              buildHeaderAction(state),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: context.read<ListingCubit>().onLoad,
                  child: buildContent(state),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
