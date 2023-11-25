part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsFailed extends NotificationsState {
  final String errMessage;

  const NotificationsFailed(this.errMessage);
}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationEntity> notifications;

  const NotificationsSuccess(this.notifications);
}
