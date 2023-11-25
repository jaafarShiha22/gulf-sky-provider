import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../domain/entities/order/order_item_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/order/get_orders_usecase.dart';
import '../data_sources/order_data_source.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource _orderDataSource;

  OrderRepositoryImpl(this._orderDataSource);

  @override
  Future<Either<Failure, OrderItemEntity>> getOrders(GetOrdersParameters parameters) async => _orderDataSource.getOrders(parameters);
}
