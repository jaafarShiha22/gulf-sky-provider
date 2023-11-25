import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:gulf_sky_provider/config/routes/app_routes.dart';
import 'package:gulf_sky_provider/features/presentation/views/request/widgets/request_card.dart';

import '../../../../core/utils/app_colors.dart';
import '../../cubits/rent_contract_info/rent_contract_info_cubit.dart';

class RequestView extends StatelessWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.addRequest,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              RequestCard(
                iconData: Icons.auto_fix_off_rounded,
                onTap: (){
                  GoRouter.of(context).push(AppRoutes.maintenanceRequestView);
                },
                title: AppLocalizations.of(context)!.maintenanceRequest,
              ),
              if (BlocProvider.of<RentContractInfoCubit>(context).rentContractInfo?.rentActive.isNotEmpty??false)
              RequestCard(
                iconData: Icons.exit_to_app_outlined,
                onTap: (){
                  GoRouter.of(context).push(AppRoutes.evacuationRequestView);
                },
                title: AppLocalizations.of(context)!.evacuationRequest,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
