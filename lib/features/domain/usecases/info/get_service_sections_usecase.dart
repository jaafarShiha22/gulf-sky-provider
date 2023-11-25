import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/service_sections_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/info_repository.dart';
import '../base_use_case.dart';

class GetServiceSectionsUseCase extends BaseUseCase<List<ServiceSectionEntity>, ServiceSectionsParameters> {
  final InfoRepository _infoRepository;

  GetServiceSectionsUseCase(this._infoRepository);

  @override
  Future<Either<Failure, List<ServiceSectionEntity>>> call(ServiceSectionsParameters parameters) async {
    return await _infoRepository.getServiceSections(parameters);
  }
}

class ServiceSectionsParameters extends Equatable {
  final int serviceId;

  const ServiceSectionsParameters({
    required this.serviceId,
  });

  @override
  List<Object> get props => [serviceId];
}
