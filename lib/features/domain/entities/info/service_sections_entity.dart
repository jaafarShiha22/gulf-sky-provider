class ServiceSectionEntity {
  final int id;
  final dynamic nameAr;
  final String name;
  final int serviceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceSectionEntity({
    required this.id,
    this.nameAr,
    required this.name,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() => name;

}
