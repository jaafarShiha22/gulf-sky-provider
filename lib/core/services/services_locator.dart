import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gulf_sky_provider/features/data/data_sources/auth_data_source.dart';
import 'package:gulf_sky_provider/features/data/data_sources/client_data_source.dart';
import 'package:gulf_sky_provider/features/data/data_sources/info_data_source.dart';
import 'package:gulf_sky_provider/features/data/data_sources/order_data_source.dart';
import 'package:gulf_sky_provider/features/data/repositories/auth_repository_impl.dart';
import 'package:gulf_sky_provider/features/data/repositories/client_repository_impl.dart';
import 'package:gulf_sky_provider/features/data/repositories/info_repository_impl.dart';
import 'package:gulf_sky_provider/features/data/repositories/packages_repository_impl.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/change_fcm_token_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/login_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/auth/register_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_contract_and_rent_info_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/get_secret_stripe.dart';
import 'package:gulf_sky_provider/features/domain/usecases/client/pay_for_package_subscription_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_buildings_by_type_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_buildings_type_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_service_sections_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_services_types_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/get_packages_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/packages/subscribe_package_usecase.dart';
import 'package:gulf_sky_provider/features/domain/usecases/request/add_evacuation_request_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/add_request/add_request_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/packages/packages_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/pay/pay_event.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/materials_by_type/materials_by_type_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/materials_types/materials_types_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/orders/orders_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/rent_contract_info/rent_contract_info_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/secret_stripe/secret_stripe_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/service_sections/service_sections_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/services_types/services_types_cubit.dart';

import '../../features/data/data_sources/add_request_data_source.dart';
import '../../features/data/data_sources/packages_data_source.dart';
import '../../features/data/repositories/add_request_repository_impl.dart';
import '../../features/data/repositories/order_repository_impl.dart';
import '../../features/domain/usecases/client/get_notifications_usecase.dart';
import '../../features/domain/usecases/client/pay_for_order_usecase.dart';
import '../../features/domain/usecases/info/get_materials_by_type_usecase.dart';
import '../../features/domain/usecases/info/get_materials_types_usecase.dart';
import '../../features/domain/usecases/order/get_orders_usecase.dart';
import '../../features/domain/usecases/packages/unsubscribe_package_usecase.dart';
import '../../features/domain/usecases/request/add_maintenance_request_usecase.dart';
import '../../features/presentation/blocs/info/info_bloc.dart';
import '../../features/presentation/blocs/pay/pay_bloc.dart';
import '../../features/presentation/cubits/notifications/notifications_cubit.dart';
import '../api/api_services.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Dio
  final dio = Dio();
  sl.registerSingleton<Dio>(dio);

  ///cubit
  sl.registerFactory(() => AuthBloc(
        sl<RegisterUseCase>(),
        sl<LoginUseCase>(),
        sl<ChangeFCMTokenUseCase>(),
      ));
  sl.registerFactory(() => InfoBloc(
        sl<GetBuildingsTypesUseCase>(),
        sl<GetBuildingsByTypeUseCase>(),
      ));
  sl.registerFactory(() => PackagesBloc(
        sl<GetPackagesUseCase>(),
        sl<SubscribePackageUseCase>(),
        sl<UnsubscribePackageUseCase>(),
      ));
  sl.registerFactory(() => ServicesTypesCubit(
        sl<GetServicesTypesUseCase>(),
      ));
  sl.registerFactory(() => ServiceSectionsCubit(
        sl<GetServiceSectionsUseCase>(),
      ));
  sl.registerFactory(() => OrdersCubit(
        sl<GetOrdersUseCase>(),
      ));
  sl.registerFactory(() => RentContractInfoCubit(
        sl<GetContractAndRentUseCase>(),
      ));

  sl.registerFactory(() => MaterialsTypesCubit(
        sl<GetMaterialsTypesUseCase>(),
      ));
  sl.registerFactory(() => MaterialsByTypeCubit(
        sl<GetMaterialsByTypeUseCase>(),
      ));
  sl.registerFactory(() => AddRequestBloc(
        sl<AddMaintenanceRequestUseCase>(),
        sl<AddEvacuationRequestUseCase>(),
      ));

  sl.registerFactory(() => SecretStripeCubit(
        sl<GetSecretStripeUseCase>(),
      ));
  sl.registerFactory(() => NotificationsCubit(
        sl<GetNotificationsUseCase>(),
      ));

  sl.registerFactory(() => PayBloc(
        sl<PayForOrderUseCase>(),
        sl<PayForPackageSubscriptionUseCase>(),
      ));

  ///use case
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton<ChangeFCMTokenUseCase>(() => ChangeFCMTokenUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl<AuthRepositoryImpl>()));

  sl.registerLazySingleton<GetBuildingsTypesUseCase>(() => GetBuildingsTypesUseCase(sl<InfoRepositoryImpl>()));
  sl.registerLazySingleton<GetBuildingsByTypeUseCase>(() => GetBuildingsByTypeUseCase(sl<InfoRepositoryImpl>()));
  sl.registerLazySingleton<GetMaterialsTypesUseCase>(() => GetMaterialsTypesUseCase(sl<InfoRepositoryImpl>()));
  sl.registerLazySingleton<GetMaterialsByTypeUseCase>(() => GetMaterialsByTypeUseCase(sl<InfoRepositoryImpl>()));

  sl.registerLazySingleton<GetServicesTypesUseCase>(() => GetServicesTypesUseCase(sl<InfoRepositoryImpl>()));
  sl.registerLazySingleton<GetServiceSectionsUseCase>(() => GetServiceSectionsUseCase(sl<InfoRepositoryImpl>()));

  sl.registerLazySingleton<AddMaintenanceRequestUseCase>(
      () => AddMaintenanceRequestUseCase(sl<AddRequestRepositoryImpl>()));
  sl.registerLazySingleton<AddEvacuationRequestUseCase>(
      () => AddEvacuationRequestUseCase(sl<AddRequestRepositoryImpl>()));

  sl.registerLazySingleton<GetPackagesUseCase>(() => GetPackagesUseCase(sl<PackagesRepositoryImpl>()));
  sl.registerLazySingleton<SubscribePackageUseCase>(() => SubscribePackageUseCase(sl<PackagesRepositoryImpl>()));
  sl.registerLazySingleton<UnsubscribePackageUseCase>(() => UnsubscribePackageUseCase(sl<PackagesRepositoryImpl>()));

  sl.registerLazySingleton<GetContractAndRentUseCase>(() => GetContractAndRentUseCase(sl<ClientRepositoryImpl>()));
  sl.registerLazySingleton<GetSecretStripeUseCase>(() => GetSecretStripeUseCase(sl<ClientRepositoryImpl>()));
  sl.registerLazySingleton<GetNotificationsUseCase>(() => GetNotificationsUseCase(sl<ClientRepositoryImpl>()));
  sl.registerLazySingleton<PayForOrderUseCase>(() => PayForOrderUseCase(sl<ClientRepositoryImpl>()));
  sl.registerLazySingleton<PayForPackageSubscriptionUseCase>(
      () => PayForPackageSubscriptionUseCase(sl<ClientRepositoryImpl>()));

  sl.registerLazySingleton<GetOrdersUseCase>(() => GetOrdersUseCase(sl<OrderRepositoryImpl>()));

  ///repository
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(sl<AuthDataSourceImpl>()),
  );
  sl.registerLazySingleton<InfoRepositoryImpl>(
    () => InfoRepositoryImpl(sl<InfoDataSourceImpl>()),
  );

  sl.registerLazySingleton<AddRequestRepositoryImpl>(
    () => AddRequestRepositoryImpl(sl<AddRequestDataSourceImpl>()),
  );
  sl.registerLazySingleton<PackagesRepositoryImpl>(
    () => PackagesRepositoryImpl(sl<PackagesDataSourceImpl>()),
  );

  sl.registerLazySingleton<ClientRepositoryImpl>(
    () => ClientRepositoryImpl(sl<ClientDataSourceImpl>()),
  );

  sl.registerLazySingleton<OrderRepositoryImpl>(
    () => OrderRepositoryImpl(sl<OrderDataSourceImpl>()),
  );

  ///remote data source
  sl.registerLazySingleton<AuthDataSourceImpl>(
    () => AuthDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<InfoDataSourceImpl>(
    () => InfoDataSourceImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<AddRequestDataSourceImpl>(
    () => AddRequestDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<PackagesDataSourceImpl>(
    () => PackagesDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<ClientDataSourceImpl>(
    () => ClientDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<OrderDataSourceImpl>(
    () => OrderDataSourceImpl(sl<ApiService>()),
  );

  /// services
  sl.registerLazySingleton<ApiService>(
    () => ApiService(dio),
  );
}
