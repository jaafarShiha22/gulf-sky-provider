import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/notification_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/rent_contract_info_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_notifications_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_package_subscription_usecase.dart';

import '../../../core/error/failure.dart';

abstract class ClientRepository {
  Future<Either<Failure, RentContractInfoEntity>> getRentAndContractInfo();
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(GetNotificationsParameters parameters);
  Future<Either<Failure, String>> getClientSecretStripe();
  Future<Either<Failure, void>> payForOrder(PayForOrderParameters parameters);
  Future<Either<Failure, void>> payForPackageSubscription(PayForPackageSubscriptionParameters parameters);
}
