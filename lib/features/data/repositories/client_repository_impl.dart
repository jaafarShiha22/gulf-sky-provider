import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/features/data/data_sources/client_data_source.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/notification_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/rent_contract_info_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_notifications_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_package_subscription_usecase.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientDataSource clientDataSource;

  ClientRepositoryImpl(this.clientDataSource);

  @override
  Future<Either<Failure, RentContractInfoEntity>> getRentAndContractInfo() async =>
      await clientDataSource.getRentAndContractInfo();

  @override
  Future<Either<Failure, String>> getClientSecretStripe() async => await clientDataSource.getClientSecretStripe();

  @override
  Future<Either<Failure, void>> payForOrder(PayForOrderParameters parameters) async =>
      await clientDataSource.payForOrder(parameters);

  @override
  Future<Either<Failure, void>> payForPackageSubscription(PayForPackageSubscriptionParameters parameters) async =>
      await clientDataSource.payForPackageSubscription(parameters);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(GetNotificationsParameters parameters) async => await clientDataSource.getNotifications(parameters);
}
