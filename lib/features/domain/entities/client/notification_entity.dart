class NotificationEntity {
  int id;
  String title;
  String text;
  int? orderId;
  int? userId;
  int? rentId;
  int? clientId;
  int? employeeId;
  bool show;
  int send;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.text,
    this.orderId,
    this.userId,
    this.rentId,
    this.clientId,
    this.employeeId,
    required this.show,
    required this.send,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "text": text,
    "order_id": orderId,
    "user_id": userId,
    "rent_id": rentId,
    "client_id": clientId,
    "employee_id": employeeId,
    "show": show,
    "send": send,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
