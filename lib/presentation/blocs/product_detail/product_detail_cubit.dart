import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final messageBloc = sl<MessageBloc>();
  final _getDetailUseCase = GetDetailUseCase(sl());
  final _getAvailabilityUseCase = GetAvailabilityUseCase(sl());
  ProductEntity product;

  ///Common
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));

  int hours = 0;
  int days = 0;
  int number = 0;
  String pickup = "";
  String dropOff = "";
  int adults = 1;
  int children = 0;
  List<RoomEntity>? rooms = [];
  int group = 0;
  int vip = 0;

  bool useGpsSatellite = false;
  bool useToddlerSeat = false;
  bool useInfantSeat = false;
  bool useVIP = false;
  bool useBreakfast = false;
  bool useService = false;
  bool useGarden = false;
  bool useClean = false;

  ProductDetailCubit({required this.product}) : super(ProductDetailInitial()) {
    onLoadDetail();
  }

  /// Load detail of product
  void onLoadDetail() async {
    try {
      ///load for boat
      if (product is BoatEntity) {
        product = (await _getDetailUseCase.call(product)) as BoatEntity;

        emit(
          BoatDetailSuccess(
            product: product,
            startDate: startDate,
            hours: hours,
            days: days,
            useToddlerSeat: useToddlerSeat,
            useInfantSeat: useInfantSeat,
            useGpsSatellite: useGpsSatellite,
          ),
        );

        ///load for car
      } else if (product is CarEntity) {
        product = (await _getDetailUseCase.call(product)) as CarEntity;
        emit(
          CarDetailSuccess(
            product: product,
            startDate: startDate,
            endDate: endDate,
            number: number,
            pickup: pickup,
            dropOff: dropOff,
            useToddlerSeat: useToddlerSeat,
            useInfantSeat: useInfantSeat,
            useGpsSatellite: useGpsSatellite,
          ),
        );
      } else if (product is EventEntity) {
        product = (await _getDetailUseCase.call(product)) as EventEntity;

        emit(
          EventDetailSuccess(
            product: product,
            startDate: startDate,
            vip: vip,
            group: group,
            useService: useService,
          ),
        );
      } else if (product is HotelEntity) {
        final results = await Future.wait([
          _getDetailUseCase.call(product),
          _getAvailabilityUseCase.call(
            item: product,
            startDate: DateFormat("yyyy-MM-dd").format(startDate),
            endDate: DateFormat("yyyy-MM-dd").format(endDate),
            adults: adults,
            children: children,
          ),
        ]);

        product = results[0] as HotelEntity;
        rooms = results[1] as List<RoomEntity>?;

        emit(HotelDetailSuccess(
          product: product,
          rooms: rooms,
          startDate: startDate,
          endDate: endDate,
          adults: adults,
          children: children,
          useVIP: useVIP,
          useBreakfast: useBreakfast,
        ));
      } else if (product is SpaceEntity) {
        product = await _getDetailUseCase.call(product);
        emit(
          SpaceDetailSuccess(
            product: product,
            startDate: startDate,
            endDate: endDate,
            adults: adults,
            children: children,
            useGarden: useGarden,
            useClean: useClean,
            useBreakfast: useBreakfast,
          ),
        );
      } else if (product is TourEntity) {
        product = await _getDetailUseCase.call(product);

        emit(
          TourDetailSuccess(
            product: product,
            startDate: startDate,
            adults: adults,
            children: children,
            useClean: useClean,
          ),
        );
      } else {
        product = await _getDetailUseCase.call(product);
        emit(ProductDetailSuccess(product: product));
      }
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }

  void updateCart() {
    if (product is BoatEntity) {
      emit(BoatDetailSuccess(
        product: product,
        startDate: startDate,
        hours: hours,
        days: days,
        useToddlerSeat: useToddlerSeat,
        useInfantSeat: useInfantSeat,
        useGpsSatellite: useGpsSatellite,
      ));
    } else if (product is CarEntity) {
      emit(CarDetailSuccess(
        product: product,
        startDate: startDate,
        endDate: endDate,
        number: number,
        pickup: pickup,
        dropOff: dropOff,
        useToddlerSeat: useToddlerSeat,
        useInfantSeat: useInfantSeat,
        useGpsSatellite: useGpsSatellite,
      ));
    } else if (product is EventEntity) {
      emit(EventDetailSuccess(
        product: product,
        startDate: startDate,
        vip: vip,
        group: group,
        useService: useService,
      ));
    } else if (product is HotelEntity) {
      emit(HotelDetailSuccess(
        product: product,
        rooms: rooms,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        useVIP: useVIP,
        useBreakfast: useBreakfast,
      ));
    } else if (product is SpaceEntity) {
      emit(SpaceDetailSuccess(
        product: product,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        useGarden: useGarden,
        useClean: useClean,
        useBreakfast: useBreakfast,
      ));
    } else if (product is TourEntity) {
      emit(TourDetailSuccess(
        product: product,
        startDate: startDate,
        adults: adults,
        children: children,
        useClean: useClean,
      ));
    } else {
      emit(ProductDetailSuccess(product: product));
    }
  }

  void checkAvailability() async {
    try {
      if (product is HotelEntity) {
        rooms = null;
        emit(HotelDetailSuccess(
          product: product,
          rooms: rooms,
          startDate: startDate,
          endDate: endDate,
          adults: adults,
          children: children,
          useVIP: useVIP,
          useBreakfast: useBreakfast,
        ));
        rooms = await _getAvailabilityUseCase.call(
          item: product,
          startDate: DateFormat("yyyy-MM-dd").format(startDate),
          endDate: DateFormat("yyyy-MM-dd").format(endDate),
          adults: adults,
          children: children,
        );

        emit(HotelDetailSuccess(
          product: product,
          rooms: rooms,
          startDate: startDate,
          endDate: endDate,
          adults: adults,
          children: children,
          useVIP: useVIP,
          useBreakfast: useBreakfast,
        ));
      }
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
