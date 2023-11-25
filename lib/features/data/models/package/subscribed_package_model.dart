import '../../../domain/entities/package/subscribed_package_entity.dart';

class SubscribedPackageModel extends SubscribedPackageEntity{
    SubscribedPackageModel({
        required super.id,
        required super.price,
    });

    factory SubscribedPackageModel.fromMap(Map<String, dynamic> json) => SubscribedPackageModel(
        id: json["id"],
        price: json["price"],
    );

}