import 'package:equatable/equatable.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_order_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';

import '../../../domain/usecases/request/add_maintenance_request_usecase.dart';

abstract class AddRequestEvent extends Equatable {
  const AddRequestEvent();

  @override
  List<Object> get props => [];
}

class AddMaintenanceRequest extends AddRequestEvent {
  final AddMaintenanceRequestParameters parameters;
  const AddMaintenanceRequest({
    required this.parameters,
  });

  @override
  List<Object> get props => [];
}


class AddEvacuationRequest extends AddRequestEvent {
  final AddEvacuationRequestParameters parameters;
  const AddEvacuationRequest({
    required this.parameters,
  });

  @override
  List<Object> get props => [];
}