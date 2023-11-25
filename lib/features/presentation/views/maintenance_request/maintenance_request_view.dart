import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gulf_sky_provider/config/routes/app_routes.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/core/utils/dialog_helper.dart';
import 'package:gulf_sky_provider/core/utils/extensions/list_extension.dart';
import 'package:gulf_sky_provider/core/utils/field_validator/field_validator.dart';
import 'package:gulf_sky_provider/features/domain/entities/auth/auth_response_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/home/rent_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/material_type_entityl.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/service_sections_entity.dart';
import 'package:gulf_sky_provider/features/domain/entities/info/services_types_entity.dart';
import 'package:gulf_sky_provider/features/domain/usecases/info/get_service_sections_usecase.dart';
import 'package:gulf_sky_provider/features/presentation/blocs/add_request/add_request_bloc.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/materials_types/materials_types_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/rent_contract_info/rent_contract_info_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/service_sections/service_sections_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/services_types/services_types_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/shared_widgets/custom_rounded_button.dart';
import 'package:gulf_sky_provider/features/presentation/shared_widgets/text_fields/app_text_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/enums/payment_type.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../domain/entities/info/material_entity.dart';
import '../../../domain/usecases/request/add_maintenance_request_usecase.dart';
import '../../blocs/add_request/add_request_event.dart';
import '../../blocs/add_request/add_request_state.dart';

class MaintenanceRequestView extends StatefulWidget {
  const MaintenanceRequestView({Key? key}) : super(key: key);

  @override
  State<MaintenanceRequestView> createState() => _MaintenanceRequestViewState();
}

class _MaintenanceRequestViewState extends State<MaintenanceRequestView> {
  int? rendId;
  AuthResponseEntity authResponseEntity = GetIt.instance.get<AuthResponseEntity>();
  final TextEditingController causeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final ValueNotifier<int> lengthOfImages = ValueNotifier(0);

  ServiceTypeEntity? selectedServiceTypeEntity;
  ServiceSectionEntity? selectedServiceSectionEntity;

  MaterialTypeEntity? selectedMaterialTypeEntity;

  ValueNotifier<int> lengthOfSelectedMaterialsEntities = ValueNotifier(0);
  List<MaterialEntity> selectedMaterialsEntities = [];

  List<XFile> images = [];
  ValueNotifier<String> radioValue = ValueNotifier('');

  LatLng? latLng;

  DateTime? visitDate;

  RentEntity? selectedRentEntity;

  @override
  void initState() {
    BlocProvider.of<ServicesTypesCubit>(context).getServicesTypes();
    // BlocProvider.of<MaterialsTypesCubit>(context).getMaterialsTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.addMaintenanceRequest,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<AddRequestBloc, AddRequestState>(
          bloc: BlocProvider.of<AddRequestBloc>(context),
          listener: (context, state) async {
            if (state is AddMaintenanceRequestLoading) {
              EasyLoading.show(status: AppLocalizations.of(context)!.loading);
            } else if (state is AddMaintenanceRequestSucceeded) {
              EasyLoading.dismiss();
              if (selectedRentEntity != null ||
                  (BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.contractActive.isNotEmpty ??
                      false)) {
                GoRouter.of(context).pop();
              } else {
                GoRouter.of(context).push(
                  AppRoutes.paymentView,
                  extra: {
                    'id': state.addMaintenanceResponseEntity.order.id,
                    'price': 150,
                    'payment_type': PaymentType.payForOrder
                  },
                );
              }
            } else if (state is AddMaintenanceRequestFailed) {
              EasyLoading.dismiss();
              ToastUtils.showToast(state.errorMsg);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.rentActive.isNotEmpty ?? false)
                    DropdownSearch<RentEntity>(
                      popupProps: PopupProps.menu(
                        constraints: const BoxConstraints(
                          maxHeight: 250,
                        ),
                        itemBuilder: (context, val, _) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              val.toString(),
                            ),
                          );
                        },
                      ),
                      items: BlocProvider.of<RentContractInfoCubit>(context)
                              .rentContractInfo
                              ?.rentActive
                              .where((rent) => rent.state == 'Active')
                              .map((rent) => rent)
                              .toList() ??
                          [],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.chooseAnApartment,
                        ),
                      ),
                      onChanged: (rent) {
                        selectedRentEntity = rent;
                      },
                      selectedItem: selectedRentEntity,
                    ),
                  BlocBuilder<ServicesTypesCubit, ServicesTypesState>(
                    bloc: BlocProvider.of<ServicesTypesCubit>(context),
                    builder: (context, state) {
                      if (state is ServicesTypesLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          ),
                        );
                      } else if (state is ServicesTypesFailure) {
                        ToastUtils.showToast(state.errMessage);
                        return Text(
                          AppLocalizations.of(context)!.error,
                          style: AppTextStyle.interRegularBlack,
                        );
                      } else if (state is ServicesTypesSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownSearch<ServiceTypeEntity>(
                            popupProps: PopupProps.menu(
                              constraints: const BoxConstraints(
                                maxHeight: 250,
                              ),
                              itemBuilder: (context, val, _) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    val.toString(),
                                  ),
                                );
                              },
                            ),
                            items: state.services,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.servicesTypes,
                              ),
                            ),
                            onChanged: (serviceType) {
                              selectedServiceTypeEntity = serviceType;
                              BlocProvider.of<ServiceSectionsCubit>(context).getServicesByType(
                                ServiceSectionsParameters(serviceId: selectedServiceTypeEntity!.id),
                              );
                            },
                            selectedItem: selectedServiceTypeEntity,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  BlocBuilder<ServiceSectionsCubit, ServiceSectionsState>(
                    bloc: BlocProvider.of<ServiceSectionsCubit>(context),
                    builder: (context, state) {
                      if (selectedServiceTypeEntity == null) return const SizedBox();
                      if (state is ServiceSectionsLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          ),
                        );
                      } else if (state is ServiceSectionsFailure) {
                        ToastUtils.showToast(state.errMessage);
                        return Text(
                          AppLocalizations.of(context)!.error,
                          style: AppTextStyle.interRegularBlack,
                        );
                      } else if (state is ServiceSectionsSuccess) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DropdownSearch<ServiceSectionEntity>(
                            popupProps: PopupProps.menu(
                              constraints: const BoxConstraints(
                                maxHeight: 250,
                              ),
                              itemBuilder: (context, val, _) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    val.toString(),
                                  ),
                                );
                              },
                            ),
                            items: state.serviceSections,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.serviceSections,
                              ),
                            ),
                            onChanged: (serviceSection) {
                              selectedServiceSectionEntity = serviceSection;
                            },
                            selectedItem: selectedServiceSectionEntity,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  // BlocBuilder<MaterialsTypesCubit, MaterialsTypesState>(
                  //   bloc: BlocProvider.of<MaterialsTypesCubit>(context),
                  //   builder: (context, state) {
                  //     if (state is MaterialsTypesLoading) {
                  //       return const Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 4.0),
                  //         child: Center(
                  //           child: CircularProgressIndicator(
                  //             color: AppColors.black,
                  //           ),
                  //         ),
                  //       );
                  //     } else if (state is MaterialsTypesFailed) {
                  //       ToastUtils.showToast(state.errorMsg);
                  //       return Text(
                  //         AppLocalizations.of(context)!.error,
                  //         style: AppTextStyle.interRegularBlack,
                  //       );
                  //     } else if (state is MaterialsTypesSucceeded) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //         child: DropdownSearch<MaterialTypeEntity>(
                  //           popupProps: PopupProps.menu(
                  //             constraints: const BoxConstraints(
                  //               maxHeight: 250,
                  //             ),
                  //             itemBuilder: (context, val, _) {
                  //               return Padding(
                  //                 padding: const EdgeInsets.all(12.0),
                  //                 child: Text(
                  //                   val.toString(),
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //           items: state.materialsTypes,
                  //           dropdownDecoratorProps: DropDownDecoratorProps(
                  //             dropdownSearchDecoration: InputDecoration(
                  //               labelText: AppLocalizations.of(context)!.materialsTypes,
                  //             ),
                  //           ),
                  //           onChanged: (materialType) {
                  //             selectedMaterialTypeEntity = materialType;
                  //             BlocProvider.of<MaterialsByTypeCubit>(context).getMaterialsByType(
                  //               GetMaterialsByTypeParameters(typeId: selectedMaterialTypeEntity!.id),
                  //             );
                  //           },
                  //           selectedItem: selectedMaterialTypeEntity,
                  //         ),
                  //       );
                  //     }
                  //     return const SizedBox();
                  //   },
                  // ),
                  // BlocBuilder<MaterialsByTypeCubit, MaterialsByTypeState>(
                  //   bloc: BlocProvider.of<MaterialsByTypeCubit>(context),
                  //   builder: (context, state) {
                  //     if (selectedMaterialTypeEntity == null) return const SizedBox();
                  //     if (state is GetMaterialsByTypeLoading) {
                  //       return const Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 4.0),
                  //         child: Center(
                  //           child: CircularProgressIndicator(
                  //             color: AppColors.black,
                  //           ),
                  //         ),
                  //       );
                  //     } else if (state is GetMaterialsByTypeFailed) {
                  //       ToastUtils.showToast(state.errorMsg);
                  //       return Text(
                  //         AppLocalizations.of(context)!.error,
                  //         style: AppTextStyle.interRegularBlack,
                  //       );
                  //     } else if (state is GetMaterialsByTypeSucceeded) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //         child: DropdownSearch<MaterialEntity>(
                  //           popupProps: PopupProps.menu(
                  //             constraints: const BoxConstraints(
                  //               maxHeight: 250,
                  //             ),
                  //             itemBuilder: (context, val, _) {
                  //               return Padding(
                  //                 padding: const EdgeInsets.all(12.0),
                  //                 child: Text(
                  //                   val.toString(),
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //           items: state.materialsByType,
                  //           dropdownDecoratorProps: DropDownDecoratorProps(
                  //             dropdownSearchDecoration: InputDecoration(
                  //               labelText: AppLocalizations.of(context)!.materialsByType,
                  //             ),
                  //           ),
                  //           onChanged: (material) {
                  //             if (material!.selectedQuantity!.value == material.quantity) {
                  //               ToastUtils.showToast(AppLocalizations.of(context)!.maximumQuantityHasBeenReached);
                  //               return;
                  //             }
                  //
                  //             if (!selectedMaterialsEntities.contains(material)) {
                  //               lengthOfSelectedMaterialsEntities.value++;
                  //               selectedMaterialsEntities.add(material);
                  //             } else {
                  //               selectedMaterialsEntities
                  //                   .singleWhere((element) => element == material)
                  //                   .selectedQuantity!
                  //                   .value += 1;
                  //             }
                  //           },
                  //           selectedItem: selectedMaterialsEntities.lastOrNull,
                  //         ),
                  //       );
                  //     }
                  //     return const SizedBox();
                  //   },
                  // ),
                  // ValueListenableBuilder<int>(
                  //   valueListenable: lengthOfSelectedMaterialsEntities,
                  //   builder: (context, val, child) {
                  //     return Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         if (selectedMaterialsEntities.isNotEmpty) Text(AppLocalizations.of(context)!.selectedItems),
                  //         ...selectedMaterialsEntities
                  //             .map(
                  //               (materialEntity) => Padding(
                  //                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  //                 child: Column(
                  //                   children: [
                  //                     Row(
                  //                       children: [
                  //                         const SizedBox(
                  //                           width: 20,
                  //                         ),
                  //                         materialEntity.image != null
                  //                             ? CircleAvatar(
                  //                                 backgroundImage: AssetImage(materialEntity.image!),
                  //                               )
                  //                             : const CircleAvatar(
                  //                                 backgroundImage: AssetImage(AssetsData.logo),
                  //                               ),
                  //                         SizedBox(
                  //                           width: 210,
                  //                           child: Padding(
                  //                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //                             child: Column(
                  //                               crossAxisAlignment: CrossAxisAlignment.start,
                  //                               children: [
                  //                                 SizedBox(
                  //                                   width: 200,
                  //                                   child: Text(
                  //                                     materialEntity.name,
                  //                                     style: AppTextStyle.interRegularBlack,
                  //                                     overflow: TextOverflow.ellipsis,
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   width: 200,
                  //                                   child: Text(
                  //                                     '${materialEntity.price} ${AppLocalizations.of(context)!.aed}',
                  //                                     style: AppTextStyle.interSmallBlack,
                  //                                     overflow: TextOverflow.ellipsis,
                  //                                   ),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         ValueListenableBuilder<int>(
                  //                           valueListenable: materialEntity.selectedQuantity!,
                  //                           builder: (context, val, child) {
                  //                             return SizedBox(
                  //                               width: 100,
                  //                               child: Row(
                  //                                 mainAxisAlignment: MainAxisAlignment.end,
                  //                                 children: [
                  //                                   GestureDetector(
                  //                                     onTap: materialEntity.selectedQuantity!.value ==
                  //                                             materialEntity.quantity
                  //                                         ? () {
                  //                                             ToastUtils.showToast(AppLocalizations.of(context)!
                  //                                                 .maximumQuantityHasBeenReached);
                  //                                           }
                  //                                         : () => materialEntity.selectedQuantity!.value++,
                  //                                     child: Container(
                  //                                       height: 30,
                  //                                       width: 30,
                  //                                       decoration: BoxDecoration(
                  //                                           borderRadius: BorderRadius.circular(25),
                  //                                           border: Border.all(
                  //                                             color: Colors.grey,
                  //                                           )),
                  //                                       child: const Icon(
                  //                                         Icons.add,
                  //                                         color: Colors.grey,
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   Padding(
                  //                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //                                     child: Text(
                  //                                       '${materialEntity.selectedQuantity!.value}',
                  //                                       style: AppTextStyle.interSmallBlack,
                  //                                     ),
                  //                                   ),
                  //                                   GestureDetector(
                  //                                     onTap: materialEntity.selectedQuantity!.value == 1
                  //                                         ? () {
                  //                                             lengthOfSelectedMaterialsEntities.value -= 1;
                  //                                             selectedMaterialsEntities.remove(materialEntity);
                  //                                           }
                  //                                         : () {
                  //                                             materialEntity.selectedQuantity!.value -= 1;
                  //                                           },
                  //                                     child: Container(
                  //                                       height: 30,
                  //                                       width: 30,
                  //                                       decoration: BoxDecoration(
                  //                                           borderRadius: BorderRadius.circular(25),
                  //                                           border: Border.all(
                  //                                             color: Colors.grey,
                  //                                           )),
                  //                                       child: const Icon(
                  //                                         Icons.remove,
                  //                                         color: Colors.grey,
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             );
                  //                           },
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     if (selectedMaterialsEntities.indexOf(materialEntity) !=
                  //                         selectedMaterialsEntities.length - 1)
                  //                       const Divider(
                  //                         thickness: 1.5,
                  //                         indent: 20,
                  //                         endIndent: 20,
                  //                       ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             )
                  //             .toList(),
                  //         if (selectedMaterialsEntities.isNotEmpty)
                  //           const Divider(
                  //             thickness: 1.5,
                  //           ),
                  //       ],
                  //     );
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 4),
                    child: AppTextField(
                      controller: causeController,
                      label: AppLocalizations.of(context)!.theProblem,
                      maxLines: 3,
                      fieldValidator: FieldValidator.notEmpty,
                    ),
                  ),
                  AppTextField(
                    controller: addressController,
                    label: AppLocalizations.of(context)!.address,
                    fieldValidator: FieldValidator.notEmpty,
                  ),
                  GestureDetector(
                    onTap: () async {
                      visitDate = await DatePickerBdaya.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        theme: DatePickerThemeBdaya(
                          doneStyle: AppTextStyle.interRegularOrange,
                          cancelStyle: AppTextStyle.interRegularBlack,
                        ),
                        locale: AppLocalizations.of(context)!.locale == 'en' ? LocaleType.en : LocaleType.ar,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.chooseVisitDate,
                          style: AppTextStyle.interRegularBlack,
                        ),
                        const Icon(Icons.schedule),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(
                          AppRoutes.mapView,
                          extra: {
                            'on_back': (location) {
                              latLng = location;
                            },
                            'lat_lng': latLng,
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.chooseLocation,
                            style: AppTextStyle.interRegularBlack,
                          ),
                          const Icon(
                            Icons.location_on_outlined,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.images}: ',
                        style: AppTextStyle.interRegularBlack,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ValueListenableBuilder<int>(
                                valueListenable: lengthOfImages,
                                builder: (context, val, child) {
                                  return Row(
                                    children: images
                                        .map(
                                          (image) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(16),
                                                  child: Image.file(
                                                    File(image.path),
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      images.remove(image);
                                                      lengthOfImages.value--;
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors.lightGrey,
                                                          borderRadius: BorderRadius.circular(16)),
                                                      child: const Icon(Icons.close),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogHelper.showImagePickerDialog(
                                    context: context,
                                    onSelectImage: (image) {
                                      lengthOfImages.value++;
                                      images.add(image!);
                                    },
                                    onRemoveImage: () {},
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(.5),
                                    ),
                                  ),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.grey.withOpacity(.5),
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.isOld}: ',
                          style: AppTextStyle.interRegularBlack,
                        ),
                        ValueListenableBuilder(
                          valueListenable: radioValue,
                          builder: (context, val, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: AppLocalizations.of(context)!.yes,
                                      activeColor: AppColors.orange,
                                      groupValue: radioValue.value,
                                      onChanged: (value) {
                                        radioValue.value = value!;
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.yes,
                                      style: AppTextStyle.interSmallBoldBlack,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: AppLocalizations.of(context)!.no,
                                      groupValue: radioValue.value,
                                      onChanged: (value) {
                                        radioValue.value = value!;
                                      },
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.no,
                                      style: AppTextStyle.interSmallBoldBlack,
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedButton(
                    label: AppLocalizations.of(context)!.request,
                    color: AppColors.black,
                    onPressed: () async {
                      if (visitDate == null) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectATimeForTheVisitFirst);
                        return;
                      }
                      if (latLng == null) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectALocationFirst);
                        return;
                      }
                      if (latLng == null) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectALocationFirst);
                        return;
                      }
                      if (selectedServiceTypeEntity == null) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectTheTypeOfTheServiceFirst);
                        return;
                      }
                      if (selectedServiceSectionEntity == null) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectTheSectionOfTheServiceFirst);
                        return;
                      }
                      if (causeController.text.isEmpty) {
                        ToastUtils.showToast(AppLocalizations.of(context)!.pleaseTellUsMoreAboutTheProblemFirst);
                        return;
                      }
                      BlocProvider.of<AddRequestBloc>(context).add(AddMaintenanceRequest(
                        parameters: AddMaintenanceRequestParameters(
                            cause: causeController.text,
                            address: addressController.text,
                            isOld: radioValue.value == AppLocalizations.of(context)!.yes,
                            images: images,
                            lat: latLng!.latitude,
                            lng: latLng!.longitude,
                            serviceId: selectedServiceTypeEntity!.id,
                            serviceSectionId: selectedServiceSectionEntity!.id,
                            visitDate: visitDate!,
                            rentId: selectedRentEntity?.id,
                            // items: selectedMaterialsEntities
                            //     .map((material) => {
                            //           'id': material.id,
                            //           'quantity': material.selectedQuantity!.value,
                            //         })
                            //     .toList(),
                            contractId: BlocProvider.of<RentContractInfoCubit>(context)
                                .rentContractInfo
                                ?.contractActive
                                .firstOrNull
                                ?.id),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
