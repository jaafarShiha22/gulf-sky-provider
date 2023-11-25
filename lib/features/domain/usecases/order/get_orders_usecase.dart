import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../entities/order/order_item_entity.dart';
import '../../repositories/order_repository.dart';
import '../base_use_case.dart';

class GetOrdersUseCase extends BaseUseCase<OrderItemEntity, GetOrdersParameters> {
  final OrderRepository _orderRepository;

  GetOrdersUseCase(this._orderRepository);

  @override
  Future<Either<Failure, OrderItemEntity>> call(GetOrdersParameters parameters) async {
    return await _orderRepository.getOrders(parameters);
  }
}


class GetOrdersParameters extends Equatable {
  final int page;

  const GetOrdersParameters({
    required this.page,
  });

  @override
  List<Object> get props => [page];
}
