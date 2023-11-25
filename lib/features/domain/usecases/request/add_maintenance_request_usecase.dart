import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/add_maintenance_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/add_request_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class AddMaintenanceRequestUseCase extends BaseUseCase<AddMaintenanceResponseEntity, AddMaintenanceRequestParameters> {
  final AddRequestRepository _requestRepository;

  AddMaintenanceRequestUseCase(this._requestRepository);

  @override
  Future<Either<Failure, AddMaintenanceResponseEntity>> call(AddMaintenanceRequestParameters parameters) async {
    return await _requestRepository.addMaintenanceRequest(parameters);
  }
}

class AddMaintenanceRequestParameters extends Equatable {
  final String cause;
  final String address;
  final DateTime visitDate;
  final double lat;
  final double lng;
  final int? rentId;
  final int? contractId;
  final int serviceId;
  final int serviceSectionId;
  final bool isOld;
  final List<XFile> images;
  final List<Map<String, int>>? items;

  const AddMaintenanceRequestParameters({
    required this.cause,
    required this.address,
    required this.visitDate,
    required this.lat,
    required this.lng,
     this.rentId,
     this.contractId,
    required this.serviceId,
    required this.serviceSectionId,
    required this.isOld,
    required this.images,
    this.items,
  });
  @override
  List<Object> get props => [];
}
