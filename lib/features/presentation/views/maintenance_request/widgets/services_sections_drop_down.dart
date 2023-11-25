// part of '../maintenance_request_view.dart';
//
// class ServicesSectionsDropDown extends StatelessWidget {
//   final ServiceTypeEntity? selectedServiceTypeEntity;
//   final void Function(ServiceSectionEntity?) onChanged;
//
//   const ServicesSectionsDropDown({
//     Key? key,
//     required this.onChanged,
//     this.selectedServiceTypeEntity,
//   }) : super(key: key);
//
//   static ServiceSectionEntity? _selectedServiceSectionEntity;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ServiceSectionsCubit, ServiceSectionsState>(
//       bloc: BlocProvider.of<ServiceSectionsCubit>(context),
//       builder: (context, state) {
//         if (selectedServiceTypeEntity == null) return const SizedBox();
//         if (state is ServiceSectionsLoading) {
//           return const Padding(
//             padding: EdgeInsets.symmetric(vertical: 4.0),
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.black,
//               ),
//             ),
//           );
//         } else if (state is ServiceSectionsFailure) {
//           ToastUtils.showToast(state.errMessage);
//           return Text(
//             AppLocalizations.of(context)!.error,
//             style: AppTextStyle.interRegularBlack,
//           );
//         } else if (state is ServiceSectionsSuccess) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: DropdownSearch<ServiceSectionEntity>(
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
//               items: state.serviceSections,
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: AppLocalizations.of(context)!.serviceSections,
//                 ),
//               ),
//               onChanged: (serviceSection) {
//                 _selectedServiceSectionEntity = serviceSection;
//                 onChanged(serviceSection);
//               },
//               selectedItem: _selectedServiceSectionEntity,
//             ),
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
