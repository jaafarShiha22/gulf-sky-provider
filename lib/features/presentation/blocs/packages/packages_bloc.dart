import 'package:bloc/bloc.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/get_packages_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/subscribe_package_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/packages/packages_state.dart';

import '../../../domain/usecases/base_use_case.dart';
import '../../../domain/usecases/packages/unsubscribe_package_usecase.dart';
import 'packages_event.dart';

class PackagesBloc extends Bloc<PackagesEvent, PackagesState> {
  final GetPackagesUseCase _getPackagesUseCase;
  final SubscribePackageUseCase _subscribePackageUseCase;
  final UnsubscribePackageUseCase _unsubscribePackageUseCase;

  PackagesBloc(
      this._getPackagesUseCase,
      this._subscribePackageUseCase,
      this._unsubscribePackageUseCase,
      ) : super(const Initial()) {

    on<GetMaintenancePackages>((event, emit) async {
      emit(const GetMaintenancePackagesLoading());
      final result = await _getPackagesUseCase(const NoParameters());
      result.fold(
            (l) => emit(GetMaintenancePackagesFailed(errorMsg: l.message)),
            (r) {
          emit(GetMaintenancePackagesSucceeded(packages: r));
        },
      );
    });

    on<SubscribePackage>((event, emit) async {
      emit(const SubscribePackageLoading());
      final result = await _subscribePackageUseCase(event.parameters);
      result.fold(
            (l) => emit(SubscribePackageFailed(errorMsg: l.message)),
            (r) {
          emit(SubscribePackageSucceeded(subscribedPackageEntity: r));
        },
      );
    });
    on<UnsubscribePackage>((event, emit) async {
      emit(const UnsubscribePackageLoading());
      final result = await _unsubscribePackageUseCase(event.parameters);
      result.fold(
            (l) => emit(UnsubscribePackageFailed(errorMsg: l.message)),
            (r) {
          emit(const UnsubscribePackageSucceeded());
        },
      );
    });
  }
}
