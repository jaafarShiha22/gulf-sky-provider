import '../../../../domain/entities/add_request/maintenance/add_maintenance_response_entity.dart';
import 'order_response_model.dart';

class AddMaintenanceResponseModel extends AddMaintenanceResponseEntity{

  AddMaintenanceResponseModel({
    required super.id,
    required super.order,
    required super.lng,
    required super.lat,
  });

  factory AddMaintenanceResponseModel.fromMap(Map<String, dynamic> json) => AddMaintenanceResponseModel(
    id: json["id"],
    order: OrderResponseModel.fromMap(json["order"]),
    lng: json["lng"],
    lat: json["lat"],
  );

}
