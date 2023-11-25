class OrderResponseEntity {
  final int id;
  final int? clientId;
  final int? rentId;
  final int? employeeId;
  final int? contractId;
  final int? branchId;
  final int? servicePartId;
  final int? serviceId;
  final DateTime? visitDate;
  final int isOld;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? images;
  final String state;
  final String? address;
  final String? note;
  final String? cause;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderResponseEntity({
    required this.id,
     this.clientId,
     this.rentId,
     this.employeeId,
     this.contractId,
     this.branchId,
     this.servicePartId,
    required this.serviceId,
     this.visitDate,
    required this.isOld,
     this.dateFrom,
    this.dateTo,
     this.images,
    required this.state,
     this.address,
    this.note,
     this.cause,
     this.createdAt,
     this.updatedAt,
  });


  Map<String, dynamic> toMap() => {
    "id": id,
    "client_id": clientId,
    "rent_id": rentId,
    "employee_id": employeeId,
    "contract_id": contractId,
    "branch_id": branchId,
    "service_part_id": servicePartId,
    "service_id": serviceId,
    "visit_date": visitDate == null ? null : "${visitDate!.year.toString().padLeft(4, '0')}-${visitDate!.month.toString().padLeft(2, '0')}-${visitDate!.day.toString().padLeft(2, '0')}",
    "is_old": isOld,
    "date_from": dateFrom == null ? null : "${dateFrom!.year.toString().padLeft(4, '0')}-${dateFrom!.month.toString().padLeft(2, '0')}-${dateFrom!.day.toString().padLeft(2, '0')}",
    "date_to": dateTo,
    "images": images,
    "state": state,
    "address": address,
    "note": note,
    "cause": cause,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}