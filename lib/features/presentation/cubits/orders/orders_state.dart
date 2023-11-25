part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersFailure extends OrdersState {
  final String errMessage;

  const OrdersFailure(this.errMessage);
}

class OrdersSuccess extends OrdersState {
  final List<OrderResponseEntity> orders;

  const OrdersSuccess(this.orders);
}
