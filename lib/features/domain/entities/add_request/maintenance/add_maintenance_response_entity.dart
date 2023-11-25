import 'package:gulf_sky_provider/features/data/models/add_request/maintenance/order_response_model.dart';
import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/order_response_entity.dart';

class AddMaintenanceResponseEntity {
  int id;
  OrderResponseEntity order;
  String lng;
  String lat;

  AddMaintenanceResponseEntity({
    required this.id,
    required this.order,
    required this.lng,
    required this.lat,
  });

  factory AddMaintenanceResponseEntity.fromJson(Map<String, dynamic> json) => AddMaintenanceResponseEntity(
    id: json["id"],
    order: OrderResponseModel.fromMap(json["order"]),
    lng: json["lng"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order": order.toMap(),
    "lng": lng,
    "lat": lat,
  };
}
