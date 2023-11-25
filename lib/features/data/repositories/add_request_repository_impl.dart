import 'package:dartz/dartz.dart';
import 'package:gulf_sky_provider/core/error/failure.dart';
import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/add_maintenance_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/repositories/add_request_repository.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_maintenance_request_usecase.dart';

import '../data_sources/add_request_data_source.dart';

class AddRequestRepositoryImpl extends AddRequestRepository {

  final AddRequestDataSource addRequestDataSource;

  AddRequestRepositoryImpl(this.addRequestDataSource);


  @override
  Future<Either<Failure, AddMaintenanceResponseEntity>> addMaintenanceRequest(AddMaintenanceRequestParameters parameters) async {
    return await addRequestDataSource.addMaintenanceRequest(parameters);
  }

  @override
  Future<Either<Failure, void>> addEvacuationRequest(AddEvacuationRequestParameters parameters) async => await addRequestDataSource.addEvacuationRequest(parameters);
}