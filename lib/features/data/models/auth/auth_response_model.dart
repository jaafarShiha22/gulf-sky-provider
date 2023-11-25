import 'package:gulf_sky_provider/features/data/models/package/contract_model.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';

import '../home/rent_model.dart';

class AuthResponseModel extends AuthResponseEntity {
  AuthResponseModel({
    required super.id,
    required super.name,
    required super.username,
    super.phone,
    super.email,
    super.mobile,
    super.address,
    super.token,
    super.fcmToken,
    super.tenant,
    super.image,
    super.lng,
    super.lat,
  });

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    mobile: json["mobile"],
    address: json["address"],
    token: json["token"],
    fcmToken: json["fcm_token"],
    tenant: json["tenant"],
    image: json["image"],
    lng: json["lng"],
    lat: json["lat"],
  );
}
