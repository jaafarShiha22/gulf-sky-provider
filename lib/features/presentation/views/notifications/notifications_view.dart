import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/notification_entity.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/notifications/notifications_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../domain/usecases/client/get_notifications_usecase.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final PagingController<int, NotificationEntity> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    BlocProvider.of<NotificationsCubit>(context).getNotifications(
      const GetNotificationsParameters(page: 0),
      _pagingController,
    );
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<NotificationsCubit>(context).getNotifications(
        GetNotificationsParameters(page: pageKey),
        _pagingController,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
              ),
            );
          } else if (state is NotificationsSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: PagedListView<int, NotificationEntity>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<NotificationEntity>(
                    itemBuilder: (context, notification, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: notification.show ? AppColors.lightGrey : AppColors.orange.withOpacity(.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.maxFinite,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: notification.show
                                          ? AppTextStyle.interRegularBoldBlack
                                          : AppTextStyle.interRegularBoldWhite,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${DateFormat.yMMMMd().format(notification.createdAt)} ${DateFormat.Hm().format(notification.createdAt)}',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: notification.show
                                          ? AppTextStyle.interXSmallBlack
                                          : AppTextStyle.interXSmallWhite,
                                    ),
                                  ),
                                  
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${notification.text} dpfbnoidf bonidfoi don ion dpfn dpn dfpn dfpn f ndn dfp ondfopndp npdin rbnpbndobrpbddbk odb idb odpbdb',
                                style: notification.show ? AppTextStyle.interSmallBlack : AppTextStyle.interSmallWhite,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
