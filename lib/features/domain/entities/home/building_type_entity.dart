class BuildingTypeEntity {
    final int id;
    final String name;
    final dynamic createdAt;
    final dynamic updatedAt;

    BuildingTypeEntity({
        required this.id,
        required this.name,
        this.createdAt,
        this.updatedAt,
    });

}