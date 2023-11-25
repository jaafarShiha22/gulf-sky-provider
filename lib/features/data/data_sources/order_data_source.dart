import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/api_services.dart';
import '../../../core/api/urls.dart';
import '../../../core/error/failure.dart';
import '../../../core/utils/dio_utils.dart';
import '../../domain/entities/order/order_item_entity.dart';
import '../../domain/usecases/order/get_orders_usecase.dart';
import '../models/order/order_response_model.dart';

abstract class OrderDataSource {
  Future<Either<Failure, OrderItemEntity>> getOrders(GetOrdersParameters parameters);

}

class OrderDataSourceImpl extends OrderDataSource{
  final ApiService _apiService;
  OrderDataSourceImpl(this._apiService);

  @override
  Future<Either<Failure, OrderItemEntity>> getOrders(GetOrdersParameters parameters) async {
    ApiResult result = await _apiService.get(
        endPoint: '${URLs.getOrders}?page=${parameters.page}',
        data: FormData.fromMap({}),
        options: DioUtils.getOptions(
          accept: true,
          withToken: true,
          contentType: true,
        ));
    // try {
      if (result.type == ApiResultType.success) {
        return right(OrderItemModel.fromMap(result.data));
      } else {
        return left(Failure(message: result.message));
      }
    // } catch (e) {
    //   return left(Failure(message: e.toString()));
    // }
  }

}