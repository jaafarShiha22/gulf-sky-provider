import 'dart:convert';

import 'package:gulf_sky_provider/features/data/models/add_request/maintenance/order_response_model.dart';
import 'package:gulf_sky_provider/features/domain/entities/order/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity{

  OrderItemModel({
     super.orderActive,
     required super.data,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> json) {
    try{
      return OrderItemModel(
        orderActive: OrderResponseModel.fromMap(json["order_active"]),
        data: List<OrderResponseModel>.from(json["data"].map((x) => OrderResponseModel.fromMap(x))),
      );
    } catch (e){
      return OrderItemModel(
        orderActive: null,
        data: List<OrderResponseModel>.from(json["data"].map((x) => OrderResponseModel.fromMap(x))),
      );
    }
  }

}