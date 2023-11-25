
import 'package:gulf_sky_provider/features/domain/entities/add_request/maintenance/add_maintenance_response_entity.dart';

abstract class AddRequestState {
  const AddRequestState();
}

class Initial extends AddRequestState {
  const Initial();
}


class AddMaintenanceRequestLoading extends AddRequestState {
  const AddMaintenanceRequestLoading();
}

class AddMaintenanceRequestSucceeded extends AddRequestState {
  final AddMaintenanceResponseEntity addMaintenanceResponseEntity;

  const AddMaintenanceRequestSucceeded({
    required this.addMaintenanceResponseEntity,
  });
}

class AddMaintenanceRequestFailed extends AddRequestState {
  final String errorMsg;

  const AddMaintenanceRequestFailed({
    required this.errorMsg,
  });
}


class AddEvacuationRequestLoading extends AddRequestState {
  const AddEvacuationRequestLoading();
}

class AddEvacuationRequestSucceeded extends AddRequestState {

  const AddEvacuationRequestSucceeded();
}

class AddEvacuationRequestFailed extends AddRequestState {
  final String errorMsg;

  const AddEvacuationRequestFailed({
    required this.errorMsg,
  });
}
