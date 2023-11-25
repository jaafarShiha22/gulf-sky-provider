import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/service_sections_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_service_sections_usecase.dart';

part 'service_sections_state.dart';

class ServiceSectionsCubit extends Cubit<ServiceSectionsState> {
  final GetServiceSectionsUseCase _getServicesTypes;

  ServiceSectionsCubit(this._getServicesTypes) : super(ServiceSectionsInitial());

  static ServiceSectionsCubit get(context) => BlocProvider.of(context);

  Future<void> getServicesByType(ServiceSectionsParameters serviceSectionsParameters) async {
    emit(ServiceSectionsLoading());
    var result = await _getServicesTypes(serviceSectionsParameters);
    result.fold((failure) {
      emit(ServiceSectionsFailure(failure.message));
    }, (services) {
      emit(ServiceSectionsSuccess(services));
    });
  }
}
