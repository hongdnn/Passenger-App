import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/trip_detail/data/repo/invoice_repo.dart';

class InvoiceRepoImpl extends InvoiceRepo {
  InvoiceRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<InvoiceData>> getInvoiceDetail(String invoiceId) async {
    try {
      final InvoiceModel result =
          await rhBaseApi.getInvoiceDetail(invoiceId: invoiceId);
      return DataSuccess<InvoiceData>(result.data!);
    } on DioError catch (e) {
      return DataFailed<InvoiceData>(e);
    }
  }
}
