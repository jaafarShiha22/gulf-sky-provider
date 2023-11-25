import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/notification_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_notifications_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_services_types_usecase.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/entities/info/services_types_entity.dart';
import '../../../domain/usecases/base_use_case.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsCubit(this._getNotificationsUseCase) : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);


  Future<void> getNotifications(GetNotificationsParameters parameters,PagingController<int, NotificationEntity> controller) async {
    if (parameters.page == 0) emit(NotificationsLoading());
    var result = await _getNotificationsUseCase(parameters);
    result.fold((failure) {
      emit(NotificationsFailed(failure.message));
    }, (notificationsList) {
      final isLastPage = notificationsList.length < 10;
      if (isLastPage) {
        controller.appendLastPage(notificationsList);
      } else {
        final nextPageKey = parameters.page + 1;
        controller.appendPage(notificationsList, nextPageKey);
      }
      emit(NotificationsSuccess(notificationsList));
    });
  }
}
