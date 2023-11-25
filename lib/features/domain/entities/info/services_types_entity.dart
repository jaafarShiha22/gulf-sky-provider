class ServiceTypeEntity {
  final int id;
  final dynamic nameAr;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceTypeEntity({
    required this.id,
    this.nameAr,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() => name;

}
