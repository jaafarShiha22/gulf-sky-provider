import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/add_maintenance_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/add_request_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../base_use_case.dart';

class AddEvacuationRequestUseCase extends BaseUseCase<void, AddEvacuationRequestParameters> {
  final AddRequestRepository _requestRepository;

  AddEvacuationRequestUseCase(this._requestRepository);

  @override
  Future<Either<Failure, void>> call(AddEvacuationRequestParameters parameters) async {
    return await _requestRepository.addEvacuationRequest(parameters);
  }
}

class AddEvacuationRequestParameters extends Equatable {
  final String cause;
  final DateTime visitDate;
  final int? rentId;

  const AddEvacuationRequestParameters({
    required this.cause,
    required this.visitDate,
     this.rentId,
  });
  @override
  List<Object> get props => [];
}
