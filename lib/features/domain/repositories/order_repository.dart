import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/order/order_item_entity.dart';
import '../usecases/order/get_orders_usecase.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderItemEntity>> getOrders(GetOrdersParameters parameters);
}