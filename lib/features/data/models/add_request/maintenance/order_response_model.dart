import '../../../../domain/entities/add_request/maintenance/order_response_entity.dart';

class OrderResponseModel extends OrderResponseEntity{

  OrderResponseModel({
    required super.id,
     super.clientId,
     super.rentId,
     super.employeeId,
     super.contractId,
     super.branchId,
     super.servicePartId,
    required super.serviceId,
     super.visitDate,
    required super.isOld,
     super.dateFrom,
    super.dateTo,
     super.images,
    required super.state,
     super.address,
    super.note,
    required super.cause,
     super.createdAt,
     super.updatedAt,
  });

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) => OrderResponseModel(
    id: json["id"],
    clientId: json["client_id"],
    rentId: json["rent_id"],
    employeeId: json["employee_id"],
    contractId: json["contract_id"],
    branchId: json["branch_id"],
    servicePartId: json["service_part_id"],
    serviceId: json["service_id"],
    visitDate: json["visit_date"] == null ? null : DateTime.parse(json["visit_date"]),
    isOld: json["is_old"]??0,
    dateFrom: json["date_from"] == null ? null : DateTime.parse(json["date_from"]),
    dateTo: json["date_to"] == null ? null : DateTime.parse(json["date_to"]),
    images: json["images"],
    state: json["state"]??'',
    address: json["address"],
    note: json["note"],
    cause: json["cause"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}