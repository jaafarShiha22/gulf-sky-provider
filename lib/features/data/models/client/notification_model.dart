import '../../../domain/entities/client/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.title,
    required super.text,
    super.orderId,
    super.userId,
    super.rentId,
    super.clientId,
    super.employeeId,
    required super.show,
    required super.send,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        text: json["text"],
        orderId: json["order_id"],
        userId: json["user_id"],
        rentId: json["rent_id"],
        clientId: json["client_id"],
        employeeId: json["employee_id"],
        show: json["show"] == 1 ? true : false,
        send: json["send"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
