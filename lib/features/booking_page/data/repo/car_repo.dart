import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';

abstract class CarRepo {
  Future<DataState<CarDescription>> getCarDetail(CarBodyRequest carBodyRequest);
}
