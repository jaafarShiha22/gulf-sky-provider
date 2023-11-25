// part of '../maintenance_request_view.dart';
// class ServicesTypesDropDown extends StatelessWidget {
//   final void Function(ServiceTypeEntity?) onChanged;
//   const ServicesTypesDropDown({Key? key, required this.onChanged}) : super(key: key);
//
//
//   static ServiceTypeEntity? _selectedServiceTypeEntity;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ServicesTypesCubit, ServicesTypesState>(
//       bloc: BlocProvider.of<ServicesTypesCubit>(context),
//       builder: (context, state) {
//         if (state is ServicesTypesLoading) {
//           return const Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.0),
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.black,
//               ),
//             ),
//           );
//         } else if (state is ServicesTypesFailure) {
//           ToastUtils.showToast(state.errMessage);
//           return Text(
//             AppLocalizations.of(context)!.error,
//             style: AppTextStyle.interRegularBlack,
//           );
//         } else if (state is ServicesTypesSuccess) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: DropdownSearch<ServiceTypeEntity>(
//               popupProps: PopupProps.menu(
//                 constraints: const BoxConstraints(
//                   maxHeight: 250,
//                 ),
//                 itemBuilder: (context, val, _) {
//                   return Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       val.toString(),
//                     ),
//                   );
//                 },
//               ),
//               items: state.services,
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: AppLocalizations.of(context)!.servicesTypes,
//                 ),
//               ),
//               onChanged: (serviceType) {
//                 _selectedServiceTypeEntity = serviceType;
//                 onChanged(serviceType);
//
//               },
//               selectedItem: _selectedServiceTypeEntity,
//             ),
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
