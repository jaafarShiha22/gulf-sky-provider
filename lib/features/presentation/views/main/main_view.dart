import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gulf_sky_provider/core/utils/app_colors.dart';
import 'package:gulf_sky_provider/core/utils/app_text_style.dart';
import 'package:gulf_sky_provider/features/presentation/cubits/rent_contract_info/rent_contract_info_cubit.dart';
import 'package:gulf_sky_provider/features/presentation/views/home/home_view.dart';
import 'package:gulf_sky_provider/features/presentation/views/settings/settings_view.dart';

import '../../../../core/utils/enums/bar_tab.dart';
import '../orders/orders_view.dart';
import '../packages/packages_view.dart';
import '../request/request_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  ValueNotifier<BarTab> currentTab = ValueNotifier(BarTab.home);

  void changeCurrentTab(int index) {
    switch (index) {
      case 0:
        currentTab.value = BarTab.request;
        break;
      case 1:
        currentTab.value = BarTab.orders;
        break;
      case 2:
        currentTab.value = BarTab.home;
        break;
      case 3:
        currentTab.value = BarTab.packages;
        break;
      case 4:
        currentTab.value = BarTab.settings;
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RentContractInfoCubit>(context).getContractAndRent();
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RentContractInfoCubit, RentContractInfoState>(
          listener: (context, state) {
            if (state is RentContractInfoLoading) {
              EasyLoading.show(
                status: AppLocalizations.of(context)!.loading,
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state is RentContractInfoSuccess) {
              EasyLoading.dismiss();
            } else if (state is RentContractInfoFailure) {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  backgroundColor: AppColors.orange,
                  title: '${AppLocalizations.of(context)!.error}!',
                  text: state.errMessage,
                confirmBtnText: AppLocalizations.of(context)!.tryAgain,
                confirmBtnColor: AppColors.orange,
                onConfirmBtnTap: (){
                  BlocProvider.of<RentContractInfoCubit>(context).getContractAndRent();
                },
                confirmBtnTextStyle: AppTextStyle.interSmallBoldWhite
              );
            }
          },
          child: ValueListenableBuilder<BarTab>(
            valueListenable: currentTab,
            builder: (context, val, child) {
              return () {
                switch (currentTab.value) {
                  case BarTab.home:
                    return const HomeView();
                  case BarTab.request:
                    return const RequestView();
                  case BarTab.orders:
                    return const OrdersView();
                  case BarTab.packages:
                    return const PackagesView();
                  case BarTab.settings:
                    return const SettingsView();
                  default:
                    return const HomeView();
                }
              }();
            },
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        activeColor: AppColors.orange,
        backgroundColor: AppColors.white,
        height: 55,
        initialActiveIndex: 2,
        color: AppColors.black.withOpacity(.8),
        items: [
          TabItem(icon: Icons.add, title: AppLocalizations.of(context)!.request),
          TabItem(icon: Icons.history, title: AppLocalizations.of(context)!.orders),
          TabItem(icon: Icons.home, title: AppLocalizations.of(context)!.home),
          TabItem(icon: Icons.local_offer_outlined, title: AppLocalizations.of(context)!.packages),
          TabItem(icon: Icons.settings, title: AppLocalizations.of(context)!.settings),
        ],
        onTap: changeCurrentTab,
      ),
    );
  }
}
