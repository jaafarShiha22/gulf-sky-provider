class SubscribedPackageEntity {
  final int id;
  final int price;

  SubscribedPackageEntity({
    required this.id,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "price": price,
  };
}