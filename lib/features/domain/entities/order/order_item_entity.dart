import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/order_response_entity.dart';

class OrderItemEntity {
  OrderResponseEntity? orderActive;
  List<OrderResponseEntity> data;

  OrderItemEntity({
     this.orderActive,
     required this.data,
  });

  Map<String, dynamic> toMap() => {
    "order_active": orderActive?.toMap(),
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}