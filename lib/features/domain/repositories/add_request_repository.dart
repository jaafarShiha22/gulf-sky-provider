import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/add_request/maintenance/add_maintenance_response_entity.dart';
import '../usecases/request/add_maintenance_request_usecase.dart';

abstract class AddRequestRepository {
  Future<Either<Failure, AddMaintenanceResponseEntity>> addMaintenanceRequest(AddMaintenanceRequestParameters parameters);
  Future<Either<Failure, void>> addEvacuationRequest(AddEvacuationRequestParameters parameters);
}
