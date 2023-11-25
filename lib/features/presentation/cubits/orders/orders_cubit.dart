import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/entities/add_request/maintenance/order_response_entity.dart';
import '../../../domain/usecases/order/get_orders_usecase.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase) : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of<OrdersCubit>(context);

  Future<void> getOrders({
    required int page,
    required PagingController<int, OrderResponseEntity> pagingController,
  }) async {
    if (page == 0) emit(OrdersLoading());
    var result = await _getOrdersUseCase(GetOrdersParameters(page: page));
    result.fold((failure) {
      emit(OrdersFailure(failure.message));
    }, (orders) {
      final isLastPage = orders.data.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(orders.data);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(orders.data, nextPageKey);
      }
      emit(OrdersSuccess(orders.data));
    });
  }
}
