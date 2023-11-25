// part of '../maintenance_request_view.dart';
//
// class RentsDropDown extends StatelessWidget {
//   final void Function(RentEntity) onSelectRent;
//   final List<RentEntity> items;
//   const RentsDropDown({
//     Key? key,
//     required this.onSelectRent,
//     required this.items,
//   }) : super(key: key);
//
//   static  RentEntity? selectedRentEntity;
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<RentEntity>(
//       popupProps: PopupProps.menu(
//         constraints: const BoxConstraints(
//           maxHeight: 250,
//         ),
//         itemBuilder: (context, val, _) {
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               val.toString(),
//             ),
//           );
//         },
//       ),
//       items: items,
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         dropdownSearchDecoration: InputDecoration(
//           labelText: AppLocalizations.of(context)!.chooseAnApartment,
//         ),
//       ),
//       onChanged: (rent){
//         onSelectRent(rent!);
//         selectedRentEntity = rent;
//       },
//       selectedItem: selectedRentEntity,
//     );
//   }
// }
