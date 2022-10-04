import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/booking_page/presentation/widget/car_detail_widget.dart';
import 'package:passenger/features/booking_page/presentation/widget/information_cars_bt.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/string_constant.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/car_option_widget.dart';
import 'package:passenger/util/widgets/custom_card_widget.dart';
import 'package:passenger/util/widgets/easy_loading.dart';

class CarTypeWidget extends StatelessWidget {
  const CarTypeWidget({
    Key? key,
    required this.currentCategory,
    required this.selectedCarType,
    required this.onTapCarItem,
  }) : super(key: key);

  final ValueNotifier<int> currentCategory;
  final ValueNotifier<CarInfoByPrice?> selectedCarType;
  final Function({
    required int currentTypeId,
    required int driverIndex,
    required BookingPageState bookingPageState,
  }) onTapCarItem;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingPageBloc, BookingPageState>(
      listenWhen: (BookingPageState previous, BookingPageState current) {
        return previous.carDescLoadState != current.carDescLoadState;
      },
      listener: (_, BookingPageState bookingState) {
        if (bookingState.carDescLoadState == LoadState.success ||
            bookingState.carDescLoadState == LoadState.failure) {
          EasyLoading().turnOffLoading();
          int indexOfCurrentCarType =
              (bookingState.carDescription ?? CarDescription())
                  .indexOfCurrentCarType(selectedCarType.value?.driverTypeId);
          Navigator.pushNamed(
            context,
            CarDetailWidget.routeName,
            arguments: CarDetailArgs(
              currentCarTypeId: indexOfCurrentCarType,
            ),
          );
        }
      },
      child: BlocBuilder<BookingPageBloc, BookingPageState>(
        buildWhen: (BookingPageState previous, BookingPageState current) =>
            previous.getListCarPriceStatus != current.getListCarPriceStatus,
        builder: (
          _,
          BookingPageState state,
        ) {
          final LoadState? status = state.getListCarPriceStatus;
          if (status == LoadState.loading || status == LoadState.none) {
            return const Center(child: CupertinoActivityIndicator());
          }

          final List<PriceByCarTypeData> categoryList =
              state.carPriceList ?? <PriceByCarTypeData>[];

          if (status == LoadState.failure || categoryList.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                width: double.maxFinite,
                alignment: Alignment.centerLeft,
                child: Text(
                  S(context).suggested_rides,
                  style: StylesConstant.ts20w500,
                ),
              ),
              Column(
                children: List<CustomCardWidget<CarInfoByPrice>>.generate(
                  categoryList.length,
                  (int categoryIndex) => CustomCardWidget<CarInfoByPrice>(
                    physics: const NeverScrollableScrollPhysics(),
                    subTitle: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            categoryList[categoryIndex].category ?? '',
                            maxLines: 1,
                            style: StylesConstant.ts14w500,
                          ),
                          InformationOfCarsBt(
                            selectedCarTypeId:
                                selectedCarType.value?.driverTypeId ??
                                    noChosenCarsInDriverList,
                            onViewCarDetail: () {
                              EasyLoading().showEasyLoading(context);
                              BlocProvider.of<BookingPageBloc>(context).add(
                                GettingCarDetailEvent(
                                  carBodyRequest: CarBodyRequest(
                                    carTypeIds: StringConstant.carTypeIds,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    data: (state.getListCarPriceStatus == LoadState.success)
                        ? (state.carPriceList?[categoryIndex].cars ??
                            <CarInfoByPrice>[])
                        : <CarInfoByPrice>[],
                    itemBuilder: (
                      BuildContext context,
                      CarInfoByPrice item,
                      int index,
                    ) {
                      final PriceByCarTypeData? driverList =
                          state.carPriceList?[categoryIndex];
                      final int currentTypeId = int.parse(
                        (driverList?.cars?[index].driverTypeId ??
                                noChosenCarsInDriverList)
                            .toString(),
                      );
                      return InkWell(
                        onTap: () {
                          onTapCarItem.call(
                            currentTypeId: currentTypeId,
                            driverIndex: categoryIndex,
                            bookingPageState: state,
                          );
                        },
                        child: CarOptionWidget(
                          color: selectedCarType.value?.driverTypeId ==
                                  currentTypeId
                              ? ColorsConstant.cFFF6E5F6
                              : Colors.transparent,
                          borderColor: selectedCarType.value?.driverTypeId ==
                                  currentTypeId
                              ? ColorsConstant.cFFA33AA3
                              : Colors.transparent,
                          data: item,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
