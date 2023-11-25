import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/field_validator/field_validator.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../domain/entities/home/rent_entity.dart';
import '../../../domain/usecases/request/add_evacuation_request_usecase.dart';
import '../../blocs/add_request/add_request_bloc.dart';
import '../../blocs/add_request/add_request_event.dart';
import '../../blocs/add_request/add_request_state.dart';
import '../../cubits/rent_contract_info/rent_contract_info_cubit.dart';
import '../../cubits/services_types/services_types_cubit.dart';
import '../../shared_widgets/custom_rounded_button.dart';
import '../../shared_widgets/text_fields/app_text_field.dart';

class EvacuationRequestView extends StatefulWidget {
  const EvacuationRequestView({Key? key}) : super(key: key);

  @override
  State<EvacuationRequestView> createState() => _EvacuationRequestViewState();
}

class _EvacuationRequestViewState extends State<EvacuationRequestView> {
  RentEntity? selectedRentEntity;
  final TextEditingController causeController = TextEditingController();
  DateTime? visitDate;

  @override
  void initState() {
    BlocProvider.of<ServicesTypesCubit>(context).getServicesTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.addEvacuationRequest,
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
            if (state is AddEvacuationRequestLoading) {
              EasyLoading.show(status: AppLocalizations.of(context)!.loading);
            } else if (state is AddEvacuationRequestSucceeded) {
              GoRouter.of(context).pop();
              EasyLoading.dismiss();
            } else if (state is AddEvacuationRequestFailed) {
              EasyLoading.dismiss();
              ToastUtils.showToast(state.errorMsg);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 4),
                      child: AppTextField(
                        controller: causeController,
                        label: AppLocalizations.of(context)!.theProblem,
                        maxLines: 3,
                        fieldValidator: FieldValidator.notEmpty,
                      ),
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

                  ],
                ),
                CustomRoundedButton(
                  label: AppLocalizations.of(context)!.request,
                  color: AppColors.black,
                  onPressed: () async {
                    if (visitDate == null) {
                      ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectATimeForTheVisitFirst);
                      return;
                    }
                    if (selectedRentEntity == null) {
                      ToastUtils.showToast(AppLocalizations.of(context)!.pleaseSelectYourFlatFirst);
                      return;
                    }
                    if (causeController.text.isEmpty) {
                      ToastUtils.showToast(AppLocalizations.of(context)!.pleaseTellUsMoreAboutTheProblemFirst);
                      return;
                    }
                    BlocProvider.of<AddRequestBloc>(context).add(AddEvacuationRequest(
                      parameters: AddEvacuationRequestParameters(
                          visitDate: visitDate!,
                          cause: causeController.text,
                          rentId: selectedRentEntity!.id
                      ),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
