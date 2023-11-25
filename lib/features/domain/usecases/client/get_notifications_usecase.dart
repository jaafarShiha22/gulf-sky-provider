import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/entities/client/rent_contract_info_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/client_repository.dart';

import '../../../../core/error/failure.dart';
import '../../entities/client/notification_entity.dart';
import '../base_use_case.dart';

class GetNotificationsUseCase extends BaseUseCase<List<NotificationEntity>, GetNotificationsParameters> {
  final ClientRepository _clientRepository;

  GetNotificationsUseCase(this._clientRepository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(GetNotificationsParameters parameters) async {
    return await _clientRepository.getNotifications(parameters);
  }
}

class GetNotificationsParameters extends Equatable {
  final int page;

  const GetNotificationsParameters({
    required this.page,
  });

  @override
  List<Object?> get props => [];
}
