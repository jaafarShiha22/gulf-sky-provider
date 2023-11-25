
class AuthResponseEntity {
  int id;
  String name;
  String username;
  String? phone;
  String? email;
  String? mobile;
  String? address;
  String? token;
  String? fcmToken;
  int? tenant;
  String? image;
  String? lng;
  String? lat;

  AuthResponseEntity({
    required this.id,
    required this.name,
    required this.username,
    this.phone,
    this.email,
    this.mobile,
    this.address,
    this.token,
    this.fcmToken,
    this.tenant,
    this.image,
    this.lng,
    this.lat,
  });


  factory AuthResponseEntity.fromMap(Map<String, dynamic> json) => AuthResponseEntity(
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

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "username": username,
    "phone": phone,
    "email": email,
    "mobile": mobile,
    "address": address,
    "token": token,
    "fcm_token": fcmToken,
    "tenant": tenant,
    "image": image,
    "lng": lng,
    "lat": lat,
  };


}
